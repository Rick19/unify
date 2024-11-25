import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unify/bloc/task_bloc.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'task-${task['id']}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  task['title'],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              task['description'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<TaskBloc>()
                        .add(UpdateTaskStatus(task['id'], true));
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.check_circle_outline),
                  label: Text('Marcar como Completada'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(color: Colors.white)
                  ),
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTask(task['id']));
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
