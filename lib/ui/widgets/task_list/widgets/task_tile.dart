import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_forge/app/services/get_it_service.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/src/task/domain/task.dart';
import 'package:focus_forge/ui/modals/add_edit_task/add_edit_task_modal.dart';
import 'package:focus_forge/ui/modals/add_edit_task/cubits/add_edit_task_cubit.dart';
import 'package:focus_forge/ui/widgets/task_list/cubits/task_list_cubit.dart';
import 'package:focus_forge/ui/widgets/task_list/widgets/delete_alert_dialog.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.index,
  });

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              final bool? delete = await showDialog(
                context: context,
                builder: (_) {
                  return const DeleteAlertDialog();
                },
              );
              if (context.mounted && delete == true) {
                await context.read<TaskListCubit>().deleteTask(task);
              }
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
          SlidableAction(
            onPressed: (_) async {
              showDialog<Task?>(
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => AddEditTaskCubit(
                    taskService: getIt<TaskService>(),
                    code: task.code,
                  )..load(),
                  child: const AddEditTaskModal(),
                ),
              ).then(
                (value) {
                  if (value == null) return;
                  context.read<TaskListCubit>().updateTask(value);
                },
              );
            },
            backgroundColor: const Color(0xFF007BFF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: AppLocalizations.of(context)!.edit,
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox.adaptive(
              value: task.isDone,
              onChanged: (value) async {
                await context.read<TaskListCubit>().updateTask(
                      task.copyWith(
                        isDone: value,
                      ),
                    );
              },
            ),
            Text('${index + 1}'),
          ],
        ),
        title: Text(task.name),
        children: task.description == null
            ? const <Widget>[]
            : [
                Text(task.description ?? ''),
              ],
      ),
    );
  }
}
