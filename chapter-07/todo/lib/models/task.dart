import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.description,
    this.isChecked = false,
  });

  final int id;
  final String description;
  final bool isChecked;

  @override
  List<Object?> get props => [id, description, isChecked];

  Task copyWith({
    int? id,
    String? description,
    bool? isChecked,
  }) =>
      Task(
        id: id ?? this.id,
        description: description ?? this.description,
        isChecked: isChecked ?? this.isChecked,
      );
}
