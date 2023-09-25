import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubits/board_cubit.dart';
import 'package:todo/pages/board_page.dart';
import 'package:todo/repositories/board_repository.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

void main() {
  late MockBoardRepository repository;
  late BoardCubit cubit;

  setUp(() {
    repository = MockBoardRepository();
    cubit = BoardCubit(repository: repository);
  });

  testWidgets(
    'BoardPage with all tasks',
    (tester) async {
      when(() => repository.fetch()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            home: BoardPage(),
          ),
        ),
      );

      expect(find.byKey(const Key('EmptyState')), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('GettedState')), findsOneWidget);
    },
  );

  testWidgets(
    'BoardPage with failure',
    (tester) async {
      when(() => repository.fetch()).thenThrow((_) async => Exception('Error'));

      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            home: BoardPage(),
          ),
        ),
      );

      expect(find.byKey(const Key('EmptyState')), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('FailureState')), findsOneWidget);
    },
  );
}
