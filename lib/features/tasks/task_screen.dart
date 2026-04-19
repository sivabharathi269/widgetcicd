import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_model.dart';
import 'task_provider.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  void _addTask() {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    ref.read(tasksProvider.notifier).addTask(title);
    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);

    List<Task> displayTasks = tasks;
    if (_searchQuery.isNotEmpty) {
      displayTasks = displayTasks
          .where((t) => t.title.toLowerCase().contains(_searchQuery))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration:
                    const InputDecoration(hintText: 'New task...'),
                    //when press enter it added
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: displayTasks.length,
              itemBuilder: (context, index) {
                final task = displayTasks[index];
//dismissible makes the task swipeble
                return Dismissible(
                  key: ValueKey(task.id),
                  //this ui shown when you swipe right
                  background: Container(
                    color: Colors.green,
                    //position of an icon
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                  //this ui runs when leftswipe
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  //this run before delete to confrom remove or not
                  confirmDismiss: (direction) async {
                    if (direction ==
                        DismissDirection.startToEnd) {
                      ref
                          .read(tasksProvider.notifier)
                          .toggleTaskCompletion(task);
                      return false;
                    }
                    return true;
                  },
 //it runs after delete
                  onDismissed: (direction) {
                    if (direction ==
                        DismissDirection.endToStart) {
                      ref
                          .read(tasksProvider.notifier)
                          .removeTask(task);
                    }
                  },
                  child: Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => ref
                            .read(tasksProvider.notifier)
                            .toggleTaskCompletion(task),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}