import 'package:focus_forge/src/common/domain/nullable.dart';
import 'package:focus_forge/src/task/domain/task.dart';

class TaskListState {
  const TaskListState({
    this.loading = false,
    this.tasks = const <Task>[],
    this.lastTask,
    this.error = '',
    this.isLastPage = false,
    this.isDone,
  });

  /// Indicates whether the task list is currently loading data.
  ///
  /// This can be used to show a loading spinner or disable user interactions
  /// while data is being fetched or updated.
  final bool loading;

  /// A list of tasks.
  ///
  /// This contains all the tasks that are currently in the task list.
  /// It is initialized as an empty list by default.
  final List<Task> tasks;

  /// The last added or modified task, if any.
  ///
  /// This can be used to highlight the most recent changes or updates in the
  /// task list. It is `null` if no tasks have been added or modified.
  final Task? lastTask;

  /// Holds an error message, if any.
  ///
  /// This can be used to display error messages related to task operations.
  /// It is initialized as an empty string by default.
  final String error;

  /// Indicates whether the current page is the last page of tasks.
  ///
  /// This can be used to determine if more tasks can be loaded or if all tasks
  /// have been fetched. It is initialized as `false` by default.
  final bool isLastPage;

  /// Indicates whether all tasks in the current list are completed.
  ///
  /// This can be used to easily check if there are any remaining tasks to be
  /// done or if all tasks have been completed. It is `null` by default.
  final bool? isDone;

  /// Creates a copy of the current [TaskListState] with updated values.
  TaskListState copyWith({
    bool? loading,
    List<Task>? tasks,
    Nullable<Task?>? lastTask,
    String? error,
    bool? isLastPage,
    Nullable<bool?>? isDone,
  }) {
    return TaskListState(
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      lastTask: lastTask?.hasValue == true ? lastTask?.value : this.lastTask,
      error: error ?? this.error,
      isLastPage: isLastPage ?? this.isLastPage,
      isDone: isDone?.hasValue == true ? isDone?.value : this.isDone,
    );
  }
}
