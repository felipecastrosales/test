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
    final tasks = _getTasks();
    if (tasks == null) {
      return;
    }

    tasks.add(newTask);
    await emitTasks(tasks);
  }

  Future<void> removeTask(Task newTask) async {
    final tasks = _getTasks();
    if (tasks == null) {
      return;
    }

    tasks.remove(newTask);
    await emitTasks(tasks);
  }

  Future<void> checkTask(Task newTask) async {
    final tasks = _getTasks();
    if (tasks == null) {
      return;
    }

    final index = tasks.indexOf(newTask);
    tasks[index] = newTask.copyWith(isChecked: !newTask.isChecked);
    await emitTasks(tasks);
  }

  List<Task>? _getTasks() {
    final state = this.state;
    if (state is! GettedTasksBoardState) {
      return null;
    }

    return state.tasks.toList();
  }

  Future<void> emitTasks(List<Task> tasks) async {
    try {
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
