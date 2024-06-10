import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/task/domain/task.dart';

abstract class ITaskRepository {
  const ITaskRepository();

  Future<DefaultResponse> findAll(
    String userCode, {
    bool? isDone,
    Task? lastTask,
    int limit = 25,
  });

  Future<DefaultResponse> save(Task task);

  Future<DefaultResponse> update(Task task);
}
