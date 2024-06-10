import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/user/domain/user.dart';

abstract class IUserRepository {
  const IUserRepository();

  Future<DefaultResponse> saveOrUpdate(User user);
}
