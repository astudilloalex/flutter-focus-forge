import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:focus_forge/src/auth/domain/i_auth_repository.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/user/domain/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository implements IAuthRepository {
  const FirebaseAuthRepository(
    this._client,
    this._googleSignIn,
  );

  final FirebaseAuth _client;
  final GoogleSignIn _googleSignIn;

  @override
  // TODO: implement authStateChanges
  Stream<DefaultResponse> get authStateChanges {
    return _client.authStateChanges().map((user) {
      return DefaultResponse(
        message: user == null ? 'unauthorized' : 'successful',
        statusCode: user == null ? 401 : 200,
        data: user == null
            ? null
            : User(
                code: user.uid,
                displayName: user.displayName,
                email: user.email,
                emailVerified: user.emailVerified,
                isAnonymous: user.isAnonymous,
                phoneNumber: user.phoneNumber,
                photoURL: user.photoURL,
              ).toJson(),
      );
    });
  }

  @override
  // TODO: implement currentUser
  Future<DefaultResponse> get currentUser async {
    return DefaultResponse(
      message: _client.currentUser == null ? 'unauthorized' : 'successful',
      statusCode: _client.currentUser == null ? 401 : 200,
      data: _client.currentUser == null
          ? null
          : User(
              code: _client.currentUser!.uid,
              displayName: _client.currentUser!.displayName,
              email: _client.currentUser!.email,
              emailVerified: _client.currentUser!.emailVerified,
              isAnonymous: _client.currentUser!.isAnonymous,
              phoneNumber: _client.currentUser!.phoneNumber,
              photoURL: _client.currentUser!.photoURL,
            ).toJson(),
    );
  }

  @override
  Future<DefaultResponse> signInWithGoogle(
    String? accessToken,
    String? idToken,
  ) async {
    final OAuthCredential oauth = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );
    final UserCredential credential = await _client.signInWithCredential(
      oauth,
    );
    return DefaultResponse(
      message: credential.user == null ? 'unauthorized' : 'successful',
      statusCode: credential.user == null ? 401 : 200,
      data: credential.user == null
          ? null
          : User(
              code: credential.user!.uid,
              displayName: credential.user!.displayName,
              email: credential.user!.email,
              emailVerified: credential.user!.emailVerified,
              isAnonymous: credential.user!.isAnonymous,
              phoneNumber: credential.user!.phoneNumber,
              photoURL: credential.user!.photoURL,
            ).toJson(),
    );
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } finally {}
    return _client.signOut();
  }
}
