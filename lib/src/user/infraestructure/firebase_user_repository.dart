import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/user/domain/i_user_repository.dart';
import 'package:focus_forge/src/user/domain/user.dart';

class FirebaseUserRepository implements IUserRepository {
  const FirebaseUserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<DefaultResponse> saveOrUpdate(User user) async {
    await _firestore.collection('users').doc(user.code).set(user.toJson());
    return DefaultResponse(
      message: 'successful',
      statusCode: 200,
      data: user.toJson(),
    );
  }
}
