// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:travio/controller/provider/auth_provider.dart';
// import 'package:travio/model/user_model.dart';

// class ProfileEditProvider with ChangeNotifier {
//   final AuthProvider _authProvider;
//   bool _isLoading = false;

//   ProfileEditProvider(this._authProvider);

//   bool get isLoading => _isLoading;

//   Future<void> updateProfile({
//     required UserModel user,
//     required String name,
//     required int phoneNumber,
//     File? imageFile,
//   }) async {
//     _setLoading(true);
//     try {
//       String? imageUrl;
//       if (imageFile != null) {
//         imageUrl = await _uploadProfilePicture(imageFile);
//       }

//       UserModel updatedUser = UserModel(
//         id: user.id,
//         name: name,
//         phonenumber: phoneNumber,
//         profile: imageUrl ?? user.profile,
//         email: user.email,
//         pronouns: user.pronouns,
//       );

//       await _authProvider.updateUserData(updatedUser);
//     } catch (e) {
//       print('Error updating profile: $e');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<String?> _uploadProfilePicture(File imageFile) async {
//     try {
//       final storageReference = FirebaseStorage.instance
//           .ref()
//           .child('profile_pictures')
//           .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//       final uploadTask = storageReference.putFile(imageFile);
//       final snapshot = await uploadTask.whenComplete(() => null);
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// }
