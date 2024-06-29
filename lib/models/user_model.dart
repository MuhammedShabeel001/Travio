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
      name: map["name"],
      email: map["email"],
      password: map["password"],
      profile: map['profile'],
      phonenumber: map["phonenumber"],
      pronouns: map["pronouns"],
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
