import 'package:flutter/material.dart';
import 'package:focus_forge/ui/pages/home/widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
        ],
      ),
    );
  }
}
