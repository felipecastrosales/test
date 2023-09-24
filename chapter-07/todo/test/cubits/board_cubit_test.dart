import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubits/board_cubit.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repositories/board_repository.dart';
import 'package:todo/states/board_state.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

const tTask = Task(id: 7, description: 'Felipe', check: true);

void main() {
  final repository = MockBoardRepository();
  final cubit = BoardCubit(repository: repository);

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
}
