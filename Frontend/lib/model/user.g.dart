// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as int? ?? 0,
      userID: json['_id'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      image: json['image'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      '_id': instance.userID,
      'fname': instance.fname,
      'lname': instance.lname,
      'image': instance.image,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
    };
