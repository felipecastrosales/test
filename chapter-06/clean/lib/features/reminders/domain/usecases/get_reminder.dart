import 'package:clean/features/reminders/domain/entities/reminder.dart';
import 'package:clean/features/reminders/domain/repositories/reminder_repository.dart';

class GetReminder {
  GetReminder({
    required ReminderRepository repository,
  }) : _repository = repository;

  final ReminderRepository _repository;

  // Future<Reminder> execute(int id) => _repository.getReminder(id);
  Future<Reminder> call(int id) => _repository.getReminder(id);
}
