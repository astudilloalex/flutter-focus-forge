import 'package:focus_forge/app/app.dart';
import 'package:focus_forge/src/auth/domain/i_auth_repository.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/task/domain/i_task_repository.dart';
import 'package:focus_forge/src/task/domain/task.dart';
import 'package:focus_forge/src/user/domain/user.dart';

class TaskService {
  const TaskService(
    this._repository,
    this._authRepository,
  );

  final ITaskRepository _repository;
  final IAuthRepository _authRepository;

  Future<List<Task>> getAll({
    bool? isDone,
    Task? lastTask,
    int limit = 25,
  }) async {
    DefaultResponse response = await _authRepository.currentUser;
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    final User? user = response.data == null
        ? null
        : User.fromJson(response.data as Map<String, dynamic>);
    response = await _repository.findAll(
      user?.code ?? '',
      isDone: isDone,
      lastTask: lastTask,
      limit: limit,
    );
    return (response.data as List<dynamic>)
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Task> create(Task task) async {
    DefaultResponse response = await _authRepository.currentUser;
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    final User? user = response.data == null
        ? null
        : User.fromJson(response.data as Map<String, dynamic>);
    response = await _repository.save(
      task.copyWith(code: generateRandomCode(), userCode: user?.code ?? ''),
    );
    return Task.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Task> update(Task task) async {
    DefaultResponse response = await _authRepository.currentUser;
    if (response.statusCode != 200) {
      throw CustomHttpException(
        code: response.statusCode,
        message: response.message,
      );
    }
    final User? user = response.data == null
        ? null
        : User.fromJson(response.data as Map<String, dynamic>);
    response = await _repository.update(
      task.copyWith(userCode: user?.code ?? ''),
    );
    return Task.fromJson(response.data as Map<String, dynamic>);
  }
}
