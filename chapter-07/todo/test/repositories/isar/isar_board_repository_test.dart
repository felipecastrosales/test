import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repositories/board_repository.dart';
import 'package:todo/repositories/isar/isar_board_repository.dart';
import 'package:todo/repositories/isar/isar_datasource.dart';
import 'package:todo/repositories/isar/task_model.dart';

class MockIsarDatasource extends Mock implements IsarDatasource {}

void main() {
  late IsarDatasource datasource;
  late BoardRepository repository;

  setUp(() {
    datasource = MockIsarDatasource();
    repository = IsarBoardRepository(datasource: datasource);
  });

  group('fetch |', () {
    test('when is success', () async {
      when(() => datasource.getTasks())
          .thenAnswer((_) async => [TaskModel()..id = 7]);
      final tasks = await repository.fetch();
      expect(tasks.length, 1);
    });
  });

  group('update |', () {
    test('when is success', () async {
      when(() => datasource.deleteAllTasks()).thenAnswer((_) async => []);
      when(() => datasource.putAllTasks(any())).thenAnswer((_) async => []);

      final tasks = await repository.update(
        tasks: const [
          Task(id: -7, description: 'Test'),
          Task(id: 7, description: 'Test'),
        ],
      );

      expect(tasks.length, 2);
    });
  });
}
