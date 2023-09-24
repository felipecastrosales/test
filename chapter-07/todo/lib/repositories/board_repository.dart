import 'package:todo/models/task.dart';

abstract class BoardRepository {
  Future<List<Task>> fetch();
  Future<List<Task>> update({required List<Task> tasks});
}
