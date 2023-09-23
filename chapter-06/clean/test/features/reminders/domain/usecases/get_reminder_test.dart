import 'package:clean/features/reminders/domain/entities/reminder.dart';
import 'package:clean/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:clean/features/reminders/domain/usecases/get_reminder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReminderRepository extends Mock implements ReminderRepository {}

const tReminder = Reminder(
  id: 7,
  title: 'Flutter',
  description: 'Is an framework',
);

void main() {
  late GetReminder usecase;
  late ReminderRepository repository;

  setUp(() {
    repository = MockReminderRepository();
    usecase = GetReminder(repository: repository);
  });

  testWidgets('Should return an Entity Reminder', (tester) async {
    /// arrange
    when(
      () => repository.getReminder(tReminder.id),
    ).thenAnswer((_) async => tReminder);

    /// act
    // final result = await usecase.execute(tReminder.id);
    final result = await usecase(tReminder.id);

    /// assert
    expect(result, tReminder);
    verify(() => repository.getReminder(tReminder.id)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
