import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:focus_forge/app/services/get_it_service.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/src/task/domain/task.dart';
import 'package:focus_forge/ui/modals/add_edit_task/add_edit_task_modal.dart';
import 'package:focus_forge/ui/modals/add_edit_task/cubits/add_edit_task_cubit.dart';
import 'package:focus_forge/ui/pages/home/widgets/home_app_bar.dart';
import 'package:focus_forge/ui/widgets/task_list/cubits/task_list_cubit.dart';
import 'package:focus_forge/ui/widgets/task_list/task_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: const TabBarView(
          children: [
            TaskListWidget(),
            TaskListWidget(),
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
                showDialog<Task?>(
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (context) => AddEditTaskCubit(
                      taskService: getIt<TaskService>(),
                    )..load(),
                    child: const AddEditTaskModal(),
                  ),
                ).then(
                  (value) {
                    if (value == null) return;
                    context.read<TaskListCubit>().addTask(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
