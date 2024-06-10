import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/ui/modals/add_edit_task/cubits/add_edit_task_cubit.dart';
import 'package:focus_forge/ui/modals/add_edit_task/widgets/add_edit_task_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddEditTaskModal extends StatelessWidget {
  const AddEditTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 450.0,
          maxHeight: 500.0,
        ),
        child: Dialog(
          child: Column(
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
              const Expanded(
                child: AddEditTaskForm(),
              ),
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
                      onPressed: () {
                        context.read<AddEditTaskCubit>().saveOrUpdate();
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
          ),
        ),
      ),
    );
  }
}
