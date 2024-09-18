import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? profile;
  int? phonenumber;
  String? pronouns;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phonenumber,
    this.profile,
    this.pronouns,
  });

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() ?? {};
    return UserModel(
      id: doc.id,
      name: data["name"] as String?,
      email: data["email"] as String?,
      password: data["password"] as String?,
      profile: data['profile'] as String?,
      phonenumber: data["phonenumber"] as int?,
      pronouns: data["pronouns"] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      'profile': profile,
      "phonenumber": phonenumber,
      "pronouns": pronouns,
    };
  }
}