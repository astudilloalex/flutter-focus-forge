import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/app/services/get_it_service.dart';
import 'package:focus_forge/firebase_options.dart';
import 'package:focus_forge/ui/routes/route_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: RoutePage.router,
        supportedLocales: AppLocalizations.supportedLocales,
        //theme: ThemeData.light().copyWith(),
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
