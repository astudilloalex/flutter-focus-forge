import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/app/app.dart';
import 'package:focus_forge/app/cubits/app_cubit.dart';
import 'package:focus_forge/ui/pages/sign_in/cubits/sign_in_cubit.dart';
import 'package:focus_forge/ui/routes/route_name.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => _signIn(context),
                      icon: const Icon(FontAwesomeIcons.google),
                      label: Text(
                        AppLocalizations.of(context)!.continueWithGoogle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    final SignInCubit cubit = context.read<SignInCubit>();
    context.loaderOverlay.show();
    try {
      final String? error = await cubit.signInWithGoogle();
      if (!context.mounted) return;
      if (cubit.state.user != null) {
        context.read<AppCubit>().setUser(cubit.state.user!);
      }
      if (error != null) {
        showErrorSnackbar(context, error);
      } else {
        context.goNamed(RouteName.home);
      }
    } on Exception {
      await cubit.signOut();
    } finally {
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
