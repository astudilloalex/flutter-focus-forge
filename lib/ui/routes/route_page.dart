import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/app/services/get_it_service.dart';
import 'package:focus_forge/src/auth/application/auth_service.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/ui/pages/home/cubits/home_cubit.dart';
import 'package:focus_forge/ui/pages/home/home_page.dart';
import 'package:focus_forge/ui/pages/sign_in/cubits/sign_in_cubit.dart';
import 'package:focus_forge/ui/pages/sign_in/sign_in_page.dart';
import 'package:focus_forge/ui/pages/splash/cubits/splash_cubit.dart';
import 'package:focus_forge/ui/pages/splash/splash_page.dart';
import 'package:focus_forge/ui/routes/route_name.dart';
import 'package:focus_forge/ui/widgets/task_list/cubits/task_list_cubit.dart';
import 'package:go_router/go_router.dart';

/// Pages availables.
class RoutePage {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  const RoutePage._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.home,
        name: RouteName.home,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => TaskListCubit(
                taskService: getIt<TaskService>(),
              )..load(),
            ),
          ],
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: RouteName.signIn,
        name: RouteName.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => SignInCubit(
            authService: getIt<AuthService>(),
          ),
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(
            authService: getIt<AuthService>(),
          ),
          child: const SplashPage(),
        ),
      ),
    ],
  );
}
