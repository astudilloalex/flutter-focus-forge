import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/common/domain/nullable.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/src/task/domain/task.dart';
import 'package:focus_forge/ui/widgets/task_list/states/task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit({
    required this.taskService,
  }) : super(const TaskListState());

  final TaskService taskService;
  final int pageLimit = 25;
  final ScrollController scrollController = ScrollController();

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  Future<void> load() async {
    await _fetchTasks();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !state.loading) {
          _fetchTasks();
        }
      },
    );
  }

  Future<void> _fetchTasks() async {
    if (state.isLastPage) return;
    emit(
      state.copyWith(
        loading: true,
        error: '',
      ),
    );
    String error = '';
    final List<Task> tasks = [...state.tasks];
    try {
      final List<Task> findedTasks = await taskService.getAll(
        isDone: state.isDone,
        lastTask: state.lastTask,
        limit: pageLimit,
      );
      tasks.addAll(findedTasks);
    } on CustomHttpException catch (e) {
      error = e.message;
    } on Exception catch (e) {
      error = e.toString();
    } finally {
      emit(
        state.copyWith(
          loading: false,
          error: error,
          tasks: tasks.toSet().toList(),
          lastTask:
              tasks.lastOrNull == null ? Nullable(null) : Nullable(tasks.last),
        ),
      );
    }
  }

  void addTask(Task task) {
    Task? lastTask;
    if (state.tasks.length % pageLimit == 0) {
      lastTask = state.tasks.lastOrNull;
    }
    final List<Task> tasks = [...state.tasks, task];
    emit(
      state.copyWith(
        tasks: tasks,
        lastTask: lastTask == null ? Nullable(null) : Nullable(lastTask),
      ),
    );
  }

  Future<void> deleteTask(Task task) async {
    final int index = state.tasks.lastIndexWhere(
      (element) => element.code == task.code,
    );
    if (index < 0) return;
    await taskService.delete(task.code);
    final List<Task> tasks = [...state.tasks];
    tasks.removeAt(index);
    emit(
      state.copyWith(
        tasks: [...tasks],
        lastTask:
            tasks.lastOrNull == null ? Nullable(null) : Nullable(tasks.last),
      ),
    );
  }

  void changeIsDone(
    bool? isDone,
  ) {
    emit(
      state.copyWith(
        isDone: isDone == null ? Nullable(null) : Nullable(isDone),
        tasks: [],
        lastTask: Nullable(null),
      ),
    );
    _fetchTasks();
  }
}
