import 'package:focus_forge/src/auth/domain/i_auth_repository.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/user/domain/i_user_repository.dart';
import 'package:focus_forge/src/user/domain/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  const AuthService(
    this._repository,
    this._userRepository,
  );

  final IAuthRepository _repository;
  final IUserRepository _userRepository;

  Future<bool> get isLoggedIn async {
    final DefaultResponse response = await _repository.currentUser;
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    return true;
  }

  Stream<bool> authStateChanges() {
    return _repository.authStateChanges.map((response) {
      if (response.statusCode == 200) return true;
      return false;
    });
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Sign in with Google.
    DefaultResponse response = await _repository.signInWithGoogle(
      googleAuth?.accessToken,
      googleAuth?.idToken,
    );
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    final User user = User.fromJson(response.data as Map<String, dynamic>);
    response = await _userRepository.saveOrUpdate(user);
    return user;
  }

  Future<void> signOut() {
    return _repository.signOut();
  }
}
