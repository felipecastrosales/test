import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repositories/board_repository.dart';
import 'package:todo/states/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit({
    required BoardRepository repository,
  })  : _repository = repository,
        super(EmptyBoardState());

  final BoardRepository _repository;

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());
    try {
      final tasks = await _repository.fetch();
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  Future<void> addTask(Task newTask) async {
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return;
    }

    try {
      final tasks = state.tasks.toList();
      tasks.add(newTask);
      await _repository.update(tasks: tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  Future<void> removeTask(Task newTask) async {
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return;
    }

    try {
      final tasks = state.tasks.toList();
      tasks.remove(newTask);
      await _repository.update(tasks: tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  Future<void> checkTask(Task newTask) async {
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return;
    }

    try {
      final tasks = state.tasks.toList();
      final index = tasks.indexOf(newTask);
      tasks[index] = newTask.copyWith(isChecked: !newTask.isChecked);
      await _repository.update(tasks: tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  @visibleForTesting
  void addTasks({required List<Task> tasks}) =>
      emit(GettedTasksBoardState(tasks: tasks));
}
