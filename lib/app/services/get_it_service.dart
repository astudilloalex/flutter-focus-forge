import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_forge/src/auth/application/auth_service.dart';
import 'package:focus_forge/src/auth/domain/i_auth_repository.dart';
import 'package:focus_forge/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Declare repositories.
  getIt.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(
      FirebaseAuth.instance,
    ),
  );

  // Declare services.
  getIt.registerFactory<AuthService>(
    () => AuthService(getIt<IAuthRepository>()),
  );
}
