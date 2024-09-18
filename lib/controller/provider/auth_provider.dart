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
import 'package:travio/model/user_model.dart';

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

  FirebaseAuth? get auth => _auth;

  bool get isChecked => _isChecked;

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

  Future<void> loginWithGoogle({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
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

          onSuccess();
        } else {
          log('User sign-in failed');
          onError('User sign-in failed');
        }
      }
    } catch (e) {
      log('Error signing in with Google: $e');
      onError('Error signing in with Google');
    }
    notifyListeners();
  }

  Future<void> verifyEmail({
    required Function(String) onSuccess,
  }) async {
    await _auth.currentUser?.sendEmailVerification();
    onSuccess("Verification email sent");
  }

  Future<void> _setLoginStatus(bool status) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyValue, status);
  }

  Future<void> getImage(ValueNotifier<String?> image) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    image.value = pickedImage.path;
  }

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
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> fetchUserData(String userId) async {
    log('Fetching user data for userId: $userId');
    if (userId.isNotEmpty) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await db.collection('users').doc(userId).get();
        log('Document snapshot retrieved');

        if (userDoc.exists) {
          log('User document exists');
          if (userDoc.data() != null) {
            log('User document data is not null');
            _user = UserModel.fromMap(userDoc);
            log('UserModel created: ${_user?.toMap()}');
            notifyListeners();
          } else {
            log('User document data is null');
          }
        } else {
          log('User document does not exist');
        }
      } catch (e) {
        log('Error fetching user data: $e');
      }
    } else {
      log("Error: User ID is empty!");
    }
  }

  Future<void> updateUserData(UserModel updatedUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedUser.id)
        .update(updatedUser.toMap());
    _user = updatedUser;
    notifyListeners();
  }

  Future<void> addUser({
    required Function(String) onError,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        log('Adding user to Firestore');
        UserModel user = UserModel(
          name: nameController.text,
          email: currentUser.email,
          profile: photoController.text,
          phonenumber: int.tryParse(phoneController.text) ?? 0,
          password: passwordController.text,
          id: currentUser.uid,
          pronouns: pronounController.text,
        );

        await db.collection("users").doc(currentUser.uid).set(user.toMap());
        log('User added to Firestore successfully');
      } else {
        log('No current user to add');
        onError('No current user to add');
      }
    } catch (e) {
      onError("Failed to add user: $e");
    }
  }

  Future<void> signup({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      log('Creating user with email and password');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final userId = userCredential.user?.uid;

      if (userId != null) {
        log('User created, verifying email');
        await verifyEmail(onSuccess: (message) {
          onSuccess();
        });

        log('Adding user to Firestore');
        await addUser(onError: (message) {
          onError(message);
        });

        log('Fetching user data');
        await fetchUserData(userId);

        log('Setting login status');
        await _setLoginStatus(true);
        dispose();
      } else {
        log('User ID is null');
        onError('User ID is null');
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      onError("Error: $e");
      notifyListeners();
    }
  }

  Future<void> signIn({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      log('Signing in with email and password');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      log('Email and password checked');

      User? user = userCredential.user;
      if (user == null) {
        throw Exception("User is null after sign-in");
      }

      log('User ID: ${user.uid}');

      await fetchUserData(user.uid);
      log('User data fetched successfully');

      await _setLoginStatus(true);
      log('Login status set successfully');

      isLoading = false;
      notifyListeners();
      log('Loading value set to false');

      try {
        log('Calling onSuccess callback');
        onSuccess();
        log('onSuccess callback completed');
      } catch (e) {
        log('Error in onSuccess callback: $e');
        onError('Error after successful sign-in: $e');
      }
    } catch (e) {
      loading.value = false;
      String errorMessage = "Sign-in failed: ${e.toString()}";
      log(errorMessage);
      onError(errorMessage);
    }
  }

  Future<void> signOut({
    required VoidCallback onSuccess,
    required Null Function(dynamic error) onError,
  }) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.clear();
      await _auth.signOut();
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }

  Future<void> resetPassword({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      loading.value = true;
      log('Sending password reset email');
      await _auth.sendPasswordResetEmail(email: emailController.text);
      onSuccess();
      loading.value = false;
    } catch (e) {
      onError("Error: $e");
      loading.value = false;
    }
    notifyListeners();
  }

  void navigateToSignupDetail(VoidCallback onNavigate) {
    onNavigate();
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
