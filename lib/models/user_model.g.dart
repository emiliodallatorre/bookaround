/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 18/04/21, 19:47
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json['uid'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    name: json['name'] as String?,
    surname: json['surname'] as String?,
    city: json['city'] as String?,
    profileImageUrl: json['profileImageUrl'] as String?,
    hasGoneThroughShowcase: json['hasGoneThroughShowcase'] as bool?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'surname': instance.surname,
      'city': instance.city,
      'profileImageUrl': instance.profileImageUrl,
      'hasGoneThroughShowcase': instance.hasGoneThroughShowcase,
    };
