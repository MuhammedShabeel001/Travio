import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travio/models/user_model.dart';
import 'package:travio/view/pages/login/login_page.dart';
import 'package:travio/view/pages/sign%20up/details_page.dart';
import 'package:travio/core/common/navbar.dart';

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

  //------------------------------------text_Controllers-------------------------------------------------------------------------------

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

  //------------------------------------phone_number_verification-------------------------------------------------------------------------------

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
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

  //------------------------------------OTP_verification-------------------------------------------------------------------------------

  Future<void> signInWithOTP(String smsCode, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await signInWithCredential(credential, context);
    } catch (e) {
      log('Failed to sign in with OTP: $e');

      // ignore: use_build_context_synchronously
      _showSnackBar(context, 'Failed to sign in with OTP');
    }
  }

  //------------------------------------text_Controllers-------------------------------------------------------------------------------

  Future<void> signInWithCredential(
      PhoneAuthCredential credential, BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        log('User logged in: ${user.uid}');
        await fetchUserData(user.uid);
        final SharedPreferences sharedPref =
            await SharedPreferences.getInstance();
        await sharedPref.setBool(keyValue, true);

        // ignore: use_build_context_synchronously
        _showSnackBar(context, 'User logged in: ${user.uid}');
      } else {
        log('User sign-in failed');

        // ignore: use_build_context_synchronously
        _showSnackBar(context, 'User sign-in failed');
      }
    } catch (e) {
      log('Failed to sign in: $e');

      // ignore: use_build_context_synchronously
      _showSnackBar(context, 'Failed to sign in');
    }
    notifyListeners();
  }

  //------------------------------------Google_authentication-------------------------------------------------------------------------------

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          log('User logged in: ${user.uid}');
          await fetchUserData(user.uid);
          final SharedPreferences sharedPref =
              await SharedPreferences.getInstance();
          await sharedPref.setBool(keyValue, true);

          // ignore: use_build_context_synchronously
          _navigateToHome(context);
        } else {
          log('User sign-in failed');

          // ignore: use_build_context_synchronously
          _showSnackBar(context, 'User sign-in failed');
        }
      }
    } catch (e) {
      log('Error signing in with Google: $e');

      // ignore: use_build_context_synchronously
      _showSnackBar(context, 'Error signing in with Google');
    }
    notifyListeners();
  }

  //------------------------------------Email_password_signup-------------------------------------------------------------------------------

  Future<void> signup(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // ignore: use_build_context_synchronously
      _navigateToSignupDetail(context);

      // ignore: use_build_context_synchronously
      await verifyEmail(context);
      await _setLoginStatus(true);
      await fetchUserData(_auth.currentUser!.uid);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, "Error: $e");
      isLoading = false;
      notifyListeners();
    }
  }

  //------------------------------------Email_verification-------------------------------------------------------------------------------

  Future<void> verifyEmail(BuildContext context) async {
    await _auth.currentUser?.sendEmailVerification();

    // ignore: use_build_context_synchronously
    _showSnackBar(context, "Verification email sent");
  }

  //------------------------------------Shared_preference-------------------------------------------------------------------------------

  Future<void> _setLoginStatus(bool status) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyValue, status);
  }

  //------------------------------------Show_snackbar-------------------------------------------------------------------------------

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  //------------------------------------Navigation_to_home-------------------------------------------------------------------------------

  void _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TTnavBar()),
      (route) => false,
    );
  }

  //------------------------------------Get_image-------------------------------------------------------------------------------

  Future<void> getImage(ValueNotifier<String?> image) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    image.value = pickedImage.path;
  }

  //------------------------------------Upload_image-------------------------------------------------------------------------------

  Future<String?> uploadImage(File image, ValueNotifier<bool> loading) async {
    try {
      loading.value = true;
      String fileName = basename(image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
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

  //------------------------------------Fetch_user_data-------------------------------------------------------------------------------

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await db.collection('users').doc(userId).get();

      _user = UserModel.fromMap(userDoc);

      notifyListeners();
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  //------------------------------------Add_user-------------------------------------------------------------------------------

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
      await db
          .collection("users")
          .doc(_auth.currentUser?.uid)
          .set(user.toMap());
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, "Failed to add user: $e");
    }
  }

  //------------------------------------Sign_in-------------------------------------------------------------------------------

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
      // ignore: use_build_context_synchronously
      _navigateToHome(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, "Error: $e");
      log("$e ................................");
      loading.value = false;
    }
  }

  //------------------------------------Sign_out-------------------------------------------------------------------------------

  Future<void> signOut(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    await _auth.signOut();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context1) => const LogInScreen()),
      (route) => false,
    );
  }

  //------------------------------------Reset_password-------------------------------------------------------------------------------

  Future<void> resetPassword(BuildContext context) async {
    try {
      loading.value = true;
      await _auth.sendPasswordResetEmail(email: emailController.text);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email sent successfully")));
      Navigator.push(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (context) => const LogInScreen()));
      loading.value = false;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
      loading.value = false;
    }
    notifyListeners();
  }

  //------------------------------------Navigate_details_screen-------------------------------------------------------------------------------

  void _navigateToSignupDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage()),
    );
  }

  //------------------------------------Dispose-------------------------------------------------------------------------------

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
