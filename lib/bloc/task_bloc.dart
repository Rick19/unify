import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      try {
        emit(TaskLoading());
        final pendingTasks = await repository.getTasks(completed: false);
        final completedTasks = await repository.getTasks(completed: true);
        emit(TaskLoaded(pendingTasks, completedTasks));
      } catch (e) {
        emit(TaskError('Error loading tasks: $e'));
      }
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(event.title, event.description);
      add(LoadTasks());
    });

    on<UpdateTaskStatus>((event, emit) async {
      await repository.updateTaskStatus(event.id, event.completed);
      add(LoadTasks());
    });

    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.id);
      add(LoadTasks());
    });
  }
}

//  Eventos del BLoC  --------------------------------------------------
abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;
  AddTask(this.title, this.description);
}

class UpdateTaskStatus extends TaskEvent {
  final int id;
  final bool completed;
  UpdateTaskStatus(this.id, this.completed);
}

class DeleteTask extends TaskEvent {
  final int id;
  DeleteTask(this.id);
}

//  Estados del BLoC  --------------------------------------------------
abstract class TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Map<String, dynamic>> pendingTasks;
  final List<Map<String, dynamic>> completedTasks;

  TaskLoaded(this.pendingTasks, this.completedTasks);
}

class TaskError extends TaskState {
  final String error;
  TaskError(this.error);
}
