import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:focus_forge/app/services/get_it_service.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/ui/modals/add_edit_task/add_edit_task_modal.dart';
import 'package:focus_forge/ui/modals/add_edit_task/cubits/add_edit_task_cubit.dart';
import 'package:focus_forge/ui/pages/home/widgets/home_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomScrollView(
        slivers: [
          HomeAppBar(),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: FontAwesomeIcons.plus,
        activeIcon: FontAwesomeIcons.xmark,
        children: [
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.listCheck),
            label: AppLocalizations.of(context)!.task,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => AddEditTaskCubit(
                    taskService: getIt<TaskService>(),
                  )..load(),
                  child: const AddEditTaskModal(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
