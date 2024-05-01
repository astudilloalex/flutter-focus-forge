import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/ui/pages/splash/cubits/splash_cubit.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Future<void> _navigate() async {
    context.goNamed(await context.read<SplashCubit>().route);
  }
}
