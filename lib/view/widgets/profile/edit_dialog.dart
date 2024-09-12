import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import '../../../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileDialog extends StatefulWidget {
  final UserModel user;

  EditProfileDialog({required this.user});

  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _phoneController.text = widget.user.phonenumber?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        'Edit Profile',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display current or newly selected profile picture
            GestureDetector(
              onTap: () => _showImagePickerOptions(context),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (widget.user.profile != null
                        ? NetworkImage(widget.user.profile!)
                        : AssetImage('assets/default_profile.png'))
                            as ImageProvider,
                child: _imageFile == null && widget.user.profile == null
                    ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            // Name field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 15),
            // Phone field with validation for 10 digits
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              onChanged: (value) {
                // Validate input length
                if (value.length > 10) {
                  _phoneController.text = value.substring(0, 10);
                  _phoneController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _phoneController.text.length));
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
          Navigator.pop(context);
          _saveProfileChanges(context);},
          child: Text('Save'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadProfilePicture(File imageFile) async {
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${widget.user.id}.jpg');

      final uploadTask = storageReference.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _saveProfileChanges(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String newName = _nameController.text.trim();
    int newPhoneNumber = int.tryParse(_phoneController.text.trim()) ?? 0;

    if (newName.isNotEmpty && newPhoneNumber > 0) {
      String? newProfilePictureUrl;

      if (_imageFile != null) {
        newProfilePictureUrl = await _uploadProfilePicture(_imageFile!);
      }

      UserModel updatedUser = UserModel(
        id: widget.user.id,
        name: newName,
        phonenumber: newPhoneNumber,
        profile: newProfilePictureUrl ?? widget.user.profile, // Use new or old profile picture URL
        email: widget.user.email,
        pronouns: widget.user.pronouns,
        password: widget.user.password
      );

      await authProvider.updateUserData(updatedUser);

      Navigator.pop(context);
    }
  }
}
