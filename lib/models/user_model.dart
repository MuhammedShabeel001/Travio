// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  // String? lastdname;
  String? email;
  String? password;
  String? profile;
  int? phonenumber;
  String? pronouns;
  // int? age;
  // String? address;

  UserModel(
      {this.id,
      this.name,
      // this.lastdname,
      this.email,
      this.password,
      this.phonenumber,
      this.profile,
      this.pronouns,
      // this.age,
      //this.address
      });

  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
        id: map.id,
        name: map["name"],
        // lastdname: map["lastdname"],
        email: map["email"],
        password: map["password"],
        profile: map['profile'],
        phonenumber: map["phonenumber"],
        pronouns: map["pronouns"],
        //age: map["age"],
        //address: map["address"]
        );
  }

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "name": name,
      // "lastdname": lastdname,
      "email": email,
      "password": password,
      'profile':profile,
      "phonenumber": phonenumber,
      "pronouns": pronouns,
      // "age": age,
      // "address": address
    };
  }
}
