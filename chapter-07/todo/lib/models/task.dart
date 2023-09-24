import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.description,
    required this.check,
  });

  final int id;
  final String description;
  final bool check;

  @override
  List<Object?> get props => [id, description, check];

  Task copyWith({
    int? id,
    String? description,
    bool? check,
  }) =>
      Task(
        id: id ?? this.id,
        description: description ?? this.description,
        check: check ?? this.check,
      );
}
