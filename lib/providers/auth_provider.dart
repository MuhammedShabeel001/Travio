import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travio/models/user_model.dart';
import 'package:travio/pages/login_page.dart';
import 'package:travio/pages/sign%20up/details_page.dart';
import 'package:travio/widgets/common/navbar.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String keyValue = 'loggedIn';

  String verificationId = '';

  bool _isChecked = false;
  bool isLoading = false;
  bool isLoadingFetchUser = false;

  UserModel? _user;
  UserModel? get user => _user;

  bool get isChecked => _isChecked;
  // bool get isLoading => _isLoading;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pronounController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  ValueNotifier<String?> imageTemporary = ValueNotifier<String?>(null);
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  void toggleCheckBox() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        log('Automatic Verification Completed: ${credential.smsCode}');
        signInWithCredential(credential, context);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification Failed: ${e.message}');
        _showSnackBar(context, 'Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        _showSnackBar(context, 'Code sent to $phoneNumber');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Verification ID timed out: $verificationId');
        _showSnackBar(context, 'Verification timed out');
      },
    );
  }

  Future<void> signInWithOTP(String smsCode, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await signInWithCredential(credential, context);
    } catch (e) {
      log('Failed to sign in with OTP: $e');
      _showSnackBar(context, 'Failed to sign in with OTP');
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        log('User logged in: ${user.uid}');
        await fetchUserData(user.uid);
        final SharedPreferences sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setBool(keyValue, true);
        _showSnackBar(context, 'User logged in: ${user.uid}');
      } else {
        log('User sign-in failed');
        _showSnackBar(context, 'User sign-in failed');
      }
    } catch (e) {
      log('Failed to sign in: $e');
      _showSnackBar(context, 'Failed to sign in');
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          log('User logged in: ${user.uid}');
          await fetchUserData(user.uid);
          final SharedPreferences sharedPref = await SharedPreferences.getInstance();
          await sharedPref.setBool(keyValue, true);
          _navigateToHome(context);
        } else {
          log('User sign-in failed');
          _showSnackBar(context, 'User sign-in failed');
        }
      }
    } catch (e) {
      log('Error signing in with Google: $e');
      _showSnackBar(context, 'Error signing in with Google');
    }
    notifyListeners();
  }

  Future<void> signup(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      _navigateToSignupDetail(context);
      await verifyEmail(context);
      await _setLoginStatus(true);
      await fetchUserData(_auth.currentUser!.uid);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      _showSnackBar(context, "Error: $e");
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyEmail(BuildContext context) async {
    await _auth.currentUser?.sendEmailVerification();
    _showSnackBar(context, "Verification email sent");
  }

  Future<void> _setLoginStatus(bool status) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyValue, status);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TTnavBar()),
      (route) => false,
    );
  }

  Future<void> getImage(ValueNotifier<String?> image) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    image.value = pickedImage.path;
  }

  Future<String?> uploadImage(File image, ValueNotifier<bool> loading) async {
    try {
      loading.value = true;
      String fileName = basename(image.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      loading.value = false;
      return downloadUrl;
    } catch (e) {
      loading.value = false;
      return null;
    }
  }

  

  Future<void> fetchUserData(String userId) async {
    try {
      // isLoadingFetchUser = true;
      DocumentSnapshot userDoc = await db.collection('users').doc(userId).get();
// var erooooooooor = userDoc.
      _user = UserModel.fromMap(userDoc);

      notifyListeners();
     
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> addUser(BuildContext context) async {
    try {
      UserModel user = UserModel(
        name: nameController.text,
        email: _auth.currentUser!.email,
        profile: photoController.text,
        phonenumber: int.parse(phoneController.text),
        password: passwordController.text,
        id: _auth.currentUser!.uid,
        pronouns: pronounController.text,
      );
      await db.collection("users").doc(_auth.currentUser?.uid).set(user.toMap());
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const TTnavBar()));
    } catch (e) {
      _showSnackBar(context, "Failed to add user: $e");
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      loading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      await fetchUserData(_auth.currentUser!.uid);
      await _setLoginStatus(true);
      loading.value = false;
      _navigateToHome(context);
    } catch (e) {
      _showSnackBar(context, "Error: $e");
      print("$e ................................");
      loading.value = false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    await _auth.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context1) => LogInScreen()),
      (route) => false,
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      loading.value = true;
      await _auth.sendPasswordResetEmail(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email sent successfully")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen()));
      loading.value = false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      loading.value = false;
    }
    notifyListeners();
  }

  void _navigateToSignupDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage()),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    pronounController.dispose();
    photoController.dispose();
    passwordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    imageTemporary.dispose();
    loading.dispose();
    super.dispose();
  }
}
