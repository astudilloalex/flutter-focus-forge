import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/task/application/task_service.dart';
import 'package:focus_forge/ui/modals/add_edit_task/states/add_edit_task_state.dart';

class AddEditTaskCubit extends Cubit<AddEditTaskState> {
  AddEditTaskCubit({
    this.code,
    required this.taskService,
  }) : super(const AddEditTaskState());

  final String? code;
  final TaskService taskService;

  Future<void> load() async {
    String? error;
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
}
