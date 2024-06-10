import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_forge/src/auth/application/auth_service.dart';
import 'package:focus_forge/src/auth/domain/i_auth_repository.dart';
import 'package:focus_forge/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/src/task/domain/i_task_repository.dart';
import 'package:focus_forge/src/task/infrastructure/firebase_task_repository.dart';
import 'package:focus_forge/src/user/application/user_service.dart';
import 'package:focus_forge/src/user/domain/i_user_repository.dart';
import 'package:focus_forge/src/user/infraestructure/firebase_user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // Declare repositories.
  getIt.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(
      FirebaseAuth.instance,
      GoogleSignIn(),
    ),
  );
  getIt.registerLazySingleton<ITaskRepository>(
    () => FirebaseTaskRepository(firebaseFirestore),
  );
  getIt.registerLazySingleton<IUserRepository>(
    () => FirebaseUserRepository(firebaseFirestore),
  );

  // Declare services.
  getIt.registerFactory<AuthService>(
    () => AuthService(
      getIt<IAuthRepository>(),
      getIt<IUserRepository>(),
    ),
  );
  getIt.registerFactory<TaskService>(
    () => TaskService(
      getIt<ITaskRepository>(),
      getIt<IAuthRepository>(),
    ),
  );
  getIt.registerFactory<UserService>(
    () => UserService(getIt<IUserRepository>()),
  );
}
