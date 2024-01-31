import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String name;
  final String email;
  // final String mobileNo;
  final String password;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    // required this.mobileNo,
    required this.password
});

  toJson(){
    return {
      'Name':name,
      'Email': email,
      'Password':password
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['Email'],
      name: data['Name'],
      password: data['Password']
    );
  }

}