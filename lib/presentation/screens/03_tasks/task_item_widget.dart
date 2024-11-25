import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unify/bloc/task_bloc.dart';
import 'package:unify/presentation/screens/03_tasks/task_detail_screen.dart';

class TaskItemWidget extends StatelessWidget {
  final Map<String, dynamic> task;
  final bool completed;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TaskDetailScreen(task: task),
        ),
      ),
      child: Dismissible(
        key: ValueKey(task['id']),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => context.read<TaskBloc>().add(DeleteTask(task['id'])),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: completed,
                onChanged: (value) {
                  if (value == true) {
                    _showCelebrationEffect(context);
                  }
                  context.read<TaskBloc>().add(UpdateTaskStatus(task['id'], value!));
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task['description'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => _showDeleteConfirmation(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar Tarea'),
        content: Text('¿Estás seguro de que deseas eliminar esta tarea?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTask(task['id']));
              Navigator.pop(context);
            },
            child: Text('Eliminar'),
          ),
        ],
      ).animate().scale(duration: 300.ms, curve: Curves.easeOut),
    );
  }

  void _showCelebrationEffect(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: Container(
          color: Colors.green.withOpacity(0.5),
          child: Center(
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 100,
            ),
          ),
        ).animate().fadeIn(delay: 1.microseconds).fadeOut(delay: 1000.ms),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(milliseconds: 1500), () {
      overlayEntry.remove();
    });
  }
}

class TaskList extends StatelessWidget {
  final bool completed;

  TaskList({required this.completed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          final tasks = completed ? state.completedTasks : state.pendingTasks;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) => TaskItemWidget(
              task: tasks[index],
              completed: completed,
            ),
          );
        } else {
          return Center(child: Text('Error al cargar las tareas.'));
        }
      },
    );
  }
}