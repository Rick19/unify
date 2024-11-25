import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unify/presentation/tab_item.dart';
import '../../../bloc/task_bloc.dart';
import 'task_item_widget.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Lista de Tareas'),
          bottom: TabBar(
            tabs: [
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  int pendingCount = 0;

                  if (state is TaskLoaded) {
                    //  Determina si el estado se ha cargado
                    pendingCount = state.pendingTasks.length;
                  }
                  return TabItem(
                    label: 'Pendientes',
                    count: pendingCount,
                  );
                },
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  int completedCount =
                      0; //  Ayuda a contar cuantas tareas completadas existen
                  if (state is TaskLoaded) {
                    completedCount = state.completedTasks.length;
                  }
                    return TabItem(
                    label: 'Completadas',
                    count: completedCount,
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskList(completed: false),
            TaskList(completed: true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Mostrar un diálogo para agregar tarea
            _showAddTaskBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //  Permite hacer scroll de ser necesario
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // Evitar conflictos con el teclado
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4, //  Altura
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.surface, //  Usa el color del tema
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(16)), // Rounded top
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, //  Evita espacios innecesarios
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nueva Tarea',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall, //  Use theme headlineMedium
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 3, // Permite un máximo de 3 líneas
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    hintText: '(opcional)',
                  ),
                ),
                Spacer(), //  Sube todo el contenido hasta arriba
                FilledButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), //  Ancho completo
                  ),
                  child: Text('Agregar'),
                  onPressed: () {
                    context.read<TaskBloc>().add(AddTask(
                        titleController.text, descriptionController.text));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
