import 'package:focus_forge/src/common/domain/default_response.dart';

abstract class IAuthRepository {
  const IAuthRepository();

  Stream<DefaultResponse> get authStateChanges;

  Future<DefaultResponse> get currentUser;

  Future<DefaultResponse> signInWithGoogle(
    String? accessToken,
    String? idToken,
  );

  Future<void> signOut();
}
