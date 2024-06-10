import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  const Task({
    this.code = '',
    required this.name,
    this.description,
    required this.creationDate,
    required this.updateDate,
    this.completedDate,
    this.isDone = false,
    this.userCode = '',
  });

  final String code;
  final String name;
  final String? description;
  final DateTime creationDate;
  final DateTime updateDate;
  final DateTime? completedDate;
  final bool isDone;
  final String userCode;

  Task copyWith({
    String? code,
    String? name,
    String? description,
    DateTime? creationDate,
    DateTime? updateDate,
    DateTime? completedDate,
    bool? isDone,
    String? userCode,
  }) {
    return Task(
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      completedDate: completedDate ?? this.completedDate,
      isDone: isDone ?? this.isDone,
      userCode: userCode ?? this.userCode,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
