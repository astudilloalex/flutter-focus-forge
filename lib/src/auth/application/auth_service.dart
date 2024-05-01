import 'package:focus_forge/src/auth/domain/i_auth_repository.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/user/domain/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  const AuthService(
    this._repository,
  );

  final IAuthRepository _repository;

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

    final DefaultResponse response = await _repository.signInWithGoogle(
      googleAuth?.accessToken,
      googleAuth?.idToken,
    );
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    return User.fromJson(response.data as Map<String, dynamic>);
  }
}
