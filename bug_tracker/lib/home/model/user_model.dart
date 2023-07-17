// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? uid;
  String name;
  String email;
  String role;
  String imgPath;
  bool isReporter;
  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.imgPath,
    required this.isReporter,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    String? imgPath,
    bool? isReporter,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      imgPath: imgPath ?? this.imgPath,
      isReporter: isReporter ?? this.isReporter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'imgPath': imgPath,
      'isReporter': isReporter,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      imgPath: map['imgPath'] as String,
      isReporter: map['isReporter'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, role: $role, imgPath: $imgPath, isReporter: $isReporter)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.role == role &&
      other.imgPath == imgPath &&
      other.isReporter == isReporter;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      role.hashCode ^
      imgPath.hashCode ^
      isReporter.hashCode;
  }
}
