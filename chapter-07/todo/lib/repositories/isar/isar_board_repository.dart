import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
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
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> update({required List<Task> tasks}) async {
    throw UnimplementedError();
  }
}
