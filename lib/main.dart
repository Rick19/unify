import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unify/bloc/task_bloc.dart';
import 'package:unify/data/task_repository.dart';
import 'package:unify/presentation/screens/01_home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(TaskRepository())..add(LoadTasks()),
      child: MaterialApp(
          title: 'Unify',
          home: HomeScreen(),
          theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.blueGrey)),
    );
  }
}
