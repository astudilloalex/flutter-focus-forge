import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/ui/modals/add_edit_task/cubits/add_edit_task_cubit.dart';
import 'package:focus_forge/ui/modals/add_edit_task/states/add_edit_task_state.dart';
import 'package:focus_forge/ui/modals/add_edit_task/widgets/add_edit_task_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddEditTaskModal extends StatelessWidget {
  const AddEditTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocSelector<AddEditTaskCubit, AddEditTaskState, bool>(
        selector: (state) => state.loading,
        builder: (context, loading) {
          if (loading) {
            return const SizedBox(
              width: 50.0,
              height: 50.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.task,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(FontAwesomeIcons.xmark),
                    ),
                  ],
                ),
              ),
              const AddEditTaskForm(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(FontAwesomeIcons.xmark),
                      label: Text(
                        AppLocalizations.of(context)!.close,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final AddEditTaskCubit cubit =
                            context.read<AddEditTaskCubit>();
                        context.loaderOverlay.show();
                        await cubit.saveOrUpdate();
                        if (!context.mounted) return;
                        context.loaderOverlay.hide();
                        Navigator.of(context).pop(cubit.state.task);
                      },
                      icon: Icon(
                        context.read<AddEditTaskCubit>().code == null
                            ? FontAwesomeIcons.floppyDisk
                            : FontAwesomeIcons.pen,
                      ),
                      label: Text(
                        context.read<AddEditTaskCubit>().code == null
                            ? AppLocalizations.of(context)!.save
                            : AppLocalizations.of(context)!.update,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
