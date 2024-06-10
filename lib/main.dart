import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/app/cubits/app_cubit.dart';
import 'package:focus_forge/app/services/get_it_service.dart';
import 'package:focus_forge/app/states/app_state.dart';
import 'package:focus_forge/firebase_options.dart';
import 'package:focus_forge/ui/routes/route_page.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..load(),
        ),
      ],
      child: MyApp(
        router: RoutePage.router,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.router,
  });

  final GoRouter router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            darkTheme: state.darkTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerConfig: router,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: state.lightTheme,
            themeMode: state.themeMode,
          );
        },
      ),
    );
  }
}

Future<void> _initialize() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
}
