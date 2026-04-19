import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_model.dart';

final tasksProvider =
NotifierProvider<TasksNotifier, List<Task>>(()=>TasksNotifier(),);

class TasksNotifier extends Notifier<List<Task>> {

  @override
  List<Task> build() {
    return [
      Task((b) => b
        ..id = '1'
        ..title = 'Explore WidgetHub'
        ..isCompleted = false),
      Task((b) => b
        ..id = '2'
        ..title = 'Learn Riverpod Providers'
        ..isCompleted = false),
      Task((b) => b
        ..id = '3'
        ..title = 'Build UI'
        ..isCompleted = false),
    ];
  }

  String _generateId() =>
      DateTime.now().microsecondsSinceEpoch.toString();

  void addTask(String title) {
    final newTask = Task((b) => b
      ..id = _generateId()
      ..title = title
      ..isCompleted = false);

    state = [newTask, ...state];
  }

  void removeTask(Task task) {
    state = state.where((t) => t.id != task.id).toList();
  }

  void toggleTaskCompletion(Task task) {
    state = state.map((t) {
      if (t.id == task.id) {
        return t.rebuild(
              (b) => b..isCompleted = !t.isCompleted,
        );
      }
      return t;
    }).toList();
  }
}