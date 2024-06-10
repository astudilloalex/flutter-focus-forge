import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/app/app.dart';
import 'package:focus_forge/ui/modals/add_edit_task/cubits/add_edit_task_cubit.dart';

class AddEditTaskForm extends StatelessWidget {
  const AddEditTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEditTaskCubit cubit = context.read<AddEditTaskCubit>();
    return Form(
      key: cubit.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: cubit.nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
              ),
              validator: (value) {
                final String? error = cubit.validateName(value);
                if (error == null) return null;
                return messageFromCode(error, context);
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: cubit.descriptionController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
              ),
              minLines: 2,
              maxLines: 4,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
