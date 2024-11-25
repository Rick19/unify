import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unify/bloc/photo_bloc.dart';
import 'package:unify/data/photo_repository.dart';
import 'package:unify/presentation/screens/02_calculator/calculator_screen.dart';
import 'package:unify/presentation/screens/03_tasks/tasks_screen.dart';
import 'package:unify/presentation/screens/04_search_api/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  Auxiliares para las transiciones de las pantallas dentro del BNB
  int _currentIndex = 0;
  int _previousIndex = 0;
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      CalculatorScreen(),
      TaskScreen(),
      BlocProvider(
        create: (context) => PhotoBloc(PhotoRepository()),
        child: SearchScreen(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 110),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final Offset beginOffset = _currentIndex > _previousIndex
              ? Offset(-1.0, 0.0) // Izquierda a derecha
              : Offset(1.0, 0.0); // Derecha a izquierda
          return SlideTransition(
            position: Tween<Offset>(
              begin: beginOffset,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar( //  Libreria de terceros: https://pub.dev/packages/curved_navigation_bar
        backgroundColor: Color.fromRGBO(15, 20, 23, 1),
        color: Colors.blueGrey.shade900,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _previousIndex = _currentIndex; // Guarda el índice anterior
            _currentIndex = index; // Cambia al nuevo índice
          });
        },
        items: [
          Icon(
            Icons.calculate_outlined,
          ),
          Icon(
            Icons.task_outlined,
          ),
          Icon(
            Icons.search,
          ),
        ],
      ),
    );
  }
}
