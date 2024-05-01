// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      code: json['code'] as String? ?? '',
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
      id: json['id'] as int? ?? 0,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'code': instance.code,
      'displayName': instance.displayName,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'id': instance.id,
      'isAnonymous': instance.isAnonymous,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
    };
