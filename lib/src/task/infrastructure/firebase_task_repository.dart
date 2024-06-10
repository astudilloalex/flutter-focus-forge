import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_forge/src/common/domain/default_response.dart';
import 'package:focus_forge/src/task/domain/i_task_repository.dart';
import 'package:focus_forge/src/task/domain/task.dart';

class FirebaseTaskRepository implements ITaskRepository {
  const FirebaseTaskRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<DefaultResponse> findAll(
    String userCode, {
    bool? isDone,
    Task? lastTask,
    int limit = 25,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> data;
    if (lastTask == null) {
      data = isDone == null
          ? await _firestore
              .collection('users')
              .doc(userCode)
              .collection('tasks')
              .orderBy('updateDate')
              .limit(limit)
              .get()
          : await _firestore
              .collection('users')
              .doc(userCode)
              .collection('tasks')
              .orderBy('updateDate')
              .where('isDone', isEqualTo: isDone)
              .limit(limit)
              .get();
      return DefaultResponse(
        message: 'successful',
        statusCode: 200,
        data: data.docs
            .map(
              (e) => e.data(),
            )
            .toList(),
      );
    }
    data = isDone == null
        ? await _firestore
            .collection('users')
            .doc(userCode)
            .collection('tasks')
            .orderBy('updateDate')
            .where('isDone', isEqualTo: isDone)
            .startAfter([lastTask.updateDate])
            .limit(limit)
            .get()
        : await _firestore
            .collection('users')
            .doc(userCode)
            .collection('tasks')
            .orderBy('updateDate')
            .startAfter([lastTask.updateDate])
            .limit(limit)
            .get();
    return DefaultResponse(
      message: 'successful',
      statusCode: 200,
      data: data.docs
          .map(
            (e) => e.data(),
          )
          .toList(),
    );
  }

  @override
  Future<DefaultResponse> save(Task task) async {
    await _firestore
        .collection('users')
        .doc(task.userCode)
        .collection('tasks')
        .doc(task.code)
        .set(task.toJson());
    return DefaultResponse(
      message: 'successful',
      statusCode: 200,
      data: task.toJson(),
    );
  }

  @override
  Future<DefaultResponse> update(Task task) async {
    await _firestore
        .collection('users')
        .doc(task.userCode)
        .collection('tasks')
        .doc(task.code)
        .update(task.toJson());
    return DefaultResponse(
      message: 'successful',
      statusCode: 200,
      data: task.toJson(),
    );
  }
}