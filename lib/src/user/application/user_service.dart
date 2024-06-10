import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/user/domain/i_user_repository.dart';
import 'package:focus_forge/src/user/domain/user.dart';

class UserService {
  const UserService(this._repository);

  final IUserRepository _repository;

  Future<User> createOrUpdate(User user) async {
    final DefaultResponse response = await _repository.saveOrUpdate(user);
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    return User.fromJson(response.data as Map<String, dynamic>);
  }
}
