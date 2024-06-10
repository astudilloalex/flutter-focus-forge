import 'package:focus_forge/src/task/domain/task.dart';

class AddEditTaskState {
  const AddEditTaskState({
    this.loading = false,
    this.task,
    this.error = '',
  });

  final bool loading;
  final Task? task;
  final String error;

  AddEditTaskState copyWith({
    bool? loading,
    Task? task,
    String? error,
  }) {
    return AddEditTaskState(
      loading: loading ?? this.loading,
      task: task ?? this.task,
      error: error ?? this.error,
    );
  }
}
