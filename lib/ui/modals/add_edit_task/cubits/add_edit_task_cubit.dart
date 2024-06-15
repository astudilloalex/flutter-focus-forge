import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/src/task/domain/task.dart';
import 'package:focus_forge/ui/modals/add_edit_task/states/add_edit_task_state.dart';

class AddEditTaskCubit extends Cubit<AddEditTaskState> {
  AddEditTaskCubit({
    this.code,
    required this.taskService,
  }) : super(const AddEditTaskState());

  final String? code;
  final TaskService taskService;

  // Controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    return super.close();
  }

  Future<void> load() async {
    String error = '';
    try {
      emit(state.copyWith(loading: true));
    } on CustomHttpException catch (e) {
      error = e.message;
    } on Exception catch (e) {
      error = e.toString();
    } finally {
      emit(
        state.copyWith(
          loading: false,
          error: error,
        ),
      );
    }
  }

  Future<void> saveOrUpdate() async {
    if (!formKey.currentState!.validate()) return;
    String error = '';
    Task? savedTask;
    try {
      emit(state.copyWith(loading: true));
      savedTask = code == null
          ? await taskService.create(
              Task(
                name: nameController.text.trim(),
                creationDate: DateTime.now(),
                updateDate: DateTime.now(),
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
              ),
            )
          : await taskService.update(
              Task(
                name: nameController.text.trim(),
                creationDate: state.task?.creationDate ?? DateTime.now(),
                updateDate: DateTime.now(),
                code: code ?? '',
                completedDate: state.task?.completedDate,
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
                isDone: state.task?.isDone ?? false,
              ),
            );
    } on CustomHttpException catch (e) {
      error = e.message;
    } on Exception catch (e) {
      error = e.toString();
    } finally {
      emit(
        state.copyWith(
          loading: false,
          error: error,
          task: savedTask,
        ),
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'invalid-name';
    }
    return null;
  }
}
