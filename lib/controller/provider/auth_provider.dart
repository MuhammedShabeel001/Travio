// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:travio/features/auth/models/user_model.dart';

// class AuthProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final String keyValue = 'loggedIn';

//   String verificationId = '';

//   bool _isChecked = false;
//   bool isLoading = false;
//   bool isLoadingFetchUser = false;

//   UserModel? _user;
//   UserModel? get user => _user;

//   bool get isChecked => _isChecked;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController pronounController = TextEditingController();
//   final TextEditingController photoController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController loginEmailController = TextEditingController();
//   final TextEditingController loginPasswordController = TextEditingController();

//   ValueNotifier<String?> imageTemporary = ValueNotifier<String?>(null);
//   ValueNotifier<bool> loading = ValueNotifier<bool>(false);

//   void toggleCheckBox() {
//     _isChecked = !_isChecked;
//     notifyListeners();
//   }

//   Future<void> loginWithGoogle({
//     required VoidCallback onSuccess,
//     required Function(String) onError,
//   }) async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );

//         final UserCredential userCredential =
//             await _auth.signInWithCredential(credential);
//         final User? user = userCredential.user;

//         if (user != null) {
//           log('User logged in: ${user.uid}');
//           fetchUserData(user.uid);
//           final SharedPreferences sharedPref =
//               await SharedPreferences.getInstance();
//           await sharedPref.setBool(keyValue, true);

//           onSuccess();
//         } else {
//           log('User sign-in failed');
//           onError('User sign-in failed');
//         }
//       }
//     } catch (e) {
//       log('Error signing in with Google: $e');
//       onError('Error signing in with Google');
//     }
//     notifyListeners();
//   }

//   Future<void> verifyEmail({
//     required Function(String) onSuccess,
//   }) async {
//     await _auth.currentUser?.sendEmailVerification();
//     onSuccess("Verification email sent");
//   }

//   Future<void> _setLoginStatus(bool status) async {
//     final SharedPreferences sharedPref = await SharedPreferences.getInstance();
//     await sharedPref.setBool(keyValue, status);
//   }

//   Future<void> getImage(ValueNotifier<String?> image) async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage == null) return;
//     image.value = pickedImage.path;
//   }

//   Future<String?> uploadImage(File image, ValueNotifier<bool> loading) async {
//     try {
//       loading.value = true;
//       String fileName = basename(image.path);
//       Reference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child('uploads/$fileName');
//       UploadTask uploadTask = firebaseStorageRef.putFile(image);
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       loading.value = false;
//       return downloadUrl;
//     } catch (e) {
//       loading.value = false;
//       return null;
//     }
//   }

//  Future<void> fetchUserData(String userId) async {
//     try {
//       DocumentSnapshot userDoc = await db.collection('users').doc(userId).get();
//       _user = UserModel.fromMap(userDoc);
//       notifyListeners();
//     } catch (e) {
//       log('Error fetching user data: $e');
//     }
//   }



//   Future<void> getUserFromPreferences() async {
//     final SharedPreferences sharedPref = await SharedPreferences.getInstance();
//     String? userDataJson = sharedPref.getString('user');

//     if (userDataJson != null) {
//       try {
//         // Convert JSON string to Map
//         Map<String, dynamic> userDataMap = jsonDecode(userDataJson);

//         // Create UserModel from Map
//         _user = UserModel.fromMap(userDataMap);
//         log('$userDataMap');
//         notifyListeners();
//       } catch (e) {
//         log('Error decoding user data: $e');
//       }
//     }
//   }

//   Future<void> addUser({
//     required Function(String) onError,
//   }) async {
//     try {
//       UserModel user = UserModel(
//         name: nameController.text,
//         email: _auth.currentUser!.email,
//         profile: photoController.text,
//         phonenumber: int.parse(phoneController.text),
//         password: passwordController.text,
//         id: _auth.currentUser!.uid,
//         pronouns: pronounController.text,
//       );
//       await db
//           .collection("users")
//           .doc(_auth.currentUser!.uid)
//           .set(user.toMap());
//     } catch (e) {
//       onError("Failed to add user: $e");
//     }
//   }

//   Future<void> signup({
//     required VoidCallback onSuccess,
//     required Function(String) onError,
//   }) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       await _auth.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       await verifyEmail(onSuccess: (message) {
//         onSuccess();
//       });

//       await addUser(onError: (message) {
//         onError(message);
//       });

//       log(_auth.currentUser!.uid);
//       fetchUserData(_auth.currentUser!.uid);
//       await _setLoginStatus(true);
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       isLoading = false;
//       onError("Error: $e");
//       notifyListeners();
//     }
//   }

//   Future<void> signIn({
//   required VoidCallback onSuccess,
//   required Function(String) onError,
// }) async {
//   try {
//     loading.value = true; // Start loading
//     notifyListeners(); // Notify listeners that loading has started

//     // Sign in the user with email and password
//     await _auth.signInWithEmailAndPassword(
//       email: loginEmailController.text,
//       password: loginPasswordController.text,
//     );

//     // Fetch user data and update the local _user variable
//     fetchUserData(_auth.currentUser!.uid);

//     // Set login status to true
//     await _setLoginStatus(true);

//     // Notify listeners that loading has finished
//     loading.value = false;
//     notifyListeners();

//     // Invoke the success callback to handle navigation
//     onSuccess();
//   } catch (e) {
//     // Handle errors
//     loading.value = false; // Stop loading
//     notifyListeners(); // Notify listeners that loading has finished
//     onError("Error: $e"); // Pass error message to callback
//     log("Sign-in error: $e"); // Log detailed error
//   }
// }


//   Future<void> signOut({
//     required VoidCallback onSuccess,
//     required Null Function(dynamic error) onError,
//   }) async {
//     try {
//       final sharedPref = await SharedPreferences.getInstance();
//       await sharedPref.clear();
//       await _auth.signOut();
//       _user = null; // Clear user data on sign out
//       onSuccess();
//       notifyListeners();
//     } catch (e) {
//       log('Error signing out: $e');
//     }
//   }

//   Future<void> resetPassword({
//     required VoidCallback onSuccess,
//     required Function(String) onError,
//   }) async {
//     try {
//       loading.value = true;
//       await _auth.sendPasswordResetEmail(email: emailController.text);
//       onSuccess();
//       loading.value = false;
//     } catch (e) {
//       onError("Error: $e");
//       loading.value = false;
//     }
//     notifyListeners();
//   }

//   void navigateToSignupDetail(VoidCallback onNavigate) {
//     onNavigate();
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     pronounController.dispose();
//     photoController.dispose();
//     passwordController.dispose();
//     loginEmailController.dispose();
//     loginPasswordController.dispose();
//     imageTemporary.dispose();
//     loading.dispose();
//     super.dispose();
//   }
// }



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
import 'package:travio/model/user_model.dart';
// import 'package:travio/features/auth/view/pages/login/login_page.dart';
// import 'package:travio/features/auth/view/pages/sign%20up/details_page.dart';
// import 'package:travio/core/common/navbar.dart';

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

  Future<void> fetchUserData(String? userId) async {
    if (userId != null && userId.isNotEmpty) {
      try {
        DocumentSnapshot userDoc = await db.collection('users').doc(userId).get();
        _user = UserModel.fromMap(userDoc);
        notifyListeners();
      } catch (e) {
        log('Error fetching user data: $e');
      }
    } else {
      log("Error: User ID is empty!");
    }
  }

  Future<void> addUser({
    required Function(String) onError,
  }) async {
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
      await db.collection("users").doc(_auth.currentUser!.uid).set(user.toMap());
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

      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await verifyEmail(onSuccess: (message) {
        onSuccess();
      });

      await addUser(onError: (message) {
        onError(message);
      });

      log(_auth.currentUser!.uid);
      await fetchUserData(_auth.currentUser!.uid);
      await _setLoginStatus(true);
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
      loading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      await fetchUserData(_auth.currentUser!.uid);
      await _setLoginStatus(true);
      loading.value = false;
      onSuccess();
    } catch (e) {
      onError("Error: $e");
      log("$e ................................");
      loading.value = false;
    }
  }

  Future<void> signOut({
    required VoidCallback onSuccess,
    required Null Function(dynamic error) onError,
  }) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    await _auth.signOut();

    onSuccess();
  }

  Future<void> resetPassword({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      loading.value = true;
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
