// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      code: json['code'] as String? ?? '',
      name: json['name'] as String,
      description: json['description'] as String?,
      creationDate: DateTime.parse(json['creationDate'] as String),
      updateDate: DateTime.parse(json['updateDate'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'creationDate': instance.creationDate.toIso8601String(),
      'updateDate': instance.updateDate.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
      'isDone': instance.isDone,
    };
