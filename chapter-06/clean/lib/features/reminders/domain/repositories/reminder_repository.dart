import 'package:clean/features/reminders/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<Reminder> getReminder(int id);
}
