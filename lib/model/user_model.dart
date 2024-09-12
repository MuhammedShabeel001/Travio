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

  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
      id: map.id,
      name: map["name"] as String?,
      email: map["email"] as String?,
      password: map["password"] as String?,
      profile: map['profile'] as String?,
      phonenumber: map["phonenumber"] as int?,
      pronouns: map["pronouns"] as String?,
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
