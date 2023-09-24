import 'package:todo/models/task.dart';

sealed class BoardState {}

final class LoadingBoardState implements BoardState {}

final class GettedTasksBoardState implements BoardState {
  GettedTasksBoardState({required this.tasks});

  final List<Task> tasks;
}

final class EmptyBoardState extends GettedTasksBoardState {
  EmptyBoardState() : super(tasks: []);
}

final class FailureBoardState extends BoardState {
  FailureBoardState({required this.message});

  final String message;
}
