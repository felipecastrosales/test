import 'package:todo/models/task.dart';
import 'package:todo/repositories/board_repository.dart';
import 'package:todo/repositories/isar/isar_datasource.dart';
import 'package:todo/repositories/isar/task_model.dart';

class IsarBoardRepository implements BoardRepository {
  IsarBoardRepository({
    required IsarDatasource datasource,
  }) : _datasource = datasource;

  final IsarDatasource _datasource;

  @override
  Future<List<Task>> fetch() async {
    final models = await _datasource.getTasks();
    return models
        .map(
          (e) => Task(
            id: e.id,
            description: e.description,
            isChecked: e.isChecked,
          ),
        )
        .toList();
  }

  @override
  Future<List<Task>> update({required List<Task> tasks}) async {
    final models = tasks.map((e) {
      final model = TaskModel()
        ..isChecked = e.isChecked
        ..description = e.description;

      if (e.id != -1) {
        model.id = e.id;
      }

      return model;
    }).toList();

    await Future.wait([
      _datasource.deleteAllTasks(),
      _datasource.putAllTasks(models),
    ]);

    return tasks;
  }
}
