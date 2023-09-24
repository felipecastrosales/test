import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubits/board_cubit.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repositories/board_repository.dart';
import 'package:todo/states/board_state.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

const tTask = Task(id: 7, description: 'Felipe');

void main() {
  late MockBoardRepository repository;
  late BoardCubit cubit;

  setUp(() {
    repository = MockBoardRepository();
    cubit = BoardCubit(repository: repository);
  });

  tearDown(() {
    reset(repository);
  });

  group('fetchTasks |', () {
    testWidgets('Should get all tasks', (tester) async {
      when(() => repository.fetch()).thenAnswer((_) async => [tTask]);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.fetchTasks();
    });

    testWidgets('Should return error when fail', (tester) async {
      when(() => repository.fetch()).thenThrow(Exception('Error'));

      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<FailureBoardState>(),
        ]),
      );

      await cubit.fetchTasks();
    });
  });

  group('addTasks |', () {
    testWidgets('Should add task', (tester) async {
      when(() => repository.update(tasks: [tTask]))
          .thenAnswer((_) async => [tTask]);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.addTask(tTask);
      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 1);
      expect(state.tasks, [tTask]);
    });

    testWidgets('Should return error when fail', (tester) async {
      when(() => repository.update(tasks: [tTask]))
          .thenThrow(Exception('Error'));

      expect(
        cubit.stream,
        emitsInOrder([
          isA<FailureBoardState>(),
        ]),
      );

      await cubit.addTask(tTask);
    });
  });

  group('removeTask |', () {
    testWidgets('Should remove an task', (tester) async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenAnswer((_) async => []);

      cubit.addTasks(tasks: [tTask]);
      expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.removeTask(tTask);
      final state = cubit.state as GettedTasksBoardState;
      expect(state.tasks.length, 0);
    });

    testWidgets('Should return error when fail', (tester) async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenThrow(Exception('Error'));

      cubit.addTasks(tasks: [tTask]);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<FailureBoardState>(),
        ]),
      );

      await cubit.removeTask(tTask);
    });
  });

  group('checkTask |', () {
    test('Should check an task', () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenAnswer((_) async => []);

      cubit.addTasks(tasks: [tTask]);

      expect((cubit.state as GettedTasksBoardState).tasks.length, 1);
      expect(
        (cubit.state as GettedTasksBoardState).tasks.first.isChecked,
        false,
      );

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.checkTask(tTask);
      final state = cubit.state as GettedTasksBoardState;
      expect(state.tasks.length, 1);
      expect(state.tasks.first.isChecked, true);
    });

    test('Should throw exception when have error', () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenThrow(Exception('Error'));

      cubit.addTasks(tasks: [tTask]);

      expect(
        cubit.stream,
        emitsInOrder(
          [isA<FailureBoardState>()],
        ),
      );

      await cubit.checkTask(tTask);
    });
  });
}
