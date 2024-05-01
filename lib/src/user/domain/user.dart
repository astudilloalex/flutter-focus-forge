import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    this.code = '',
    this.displayName,
    this.email,
    this.emailVerified = false,
    this.id = 0,
    this.isAnonymous = false,
    this.phoneNumber,
    this.photoURL,
  });

  final String code;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final int id;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? photoURL;

  User copyWith({
    String? code,
    String? displayName,
    String? email,
    bool? emailVerified,
    int? id,
    bool? isAnonymous,
    String? phoneNumber,
    String? photoURL,
  }) {
    return User(
      code: code ?? this.code,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      id: id ?? this.id,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
