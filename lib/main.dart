import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/todo_list_screen.dart';
import 'screens/add_todo_screen.dart';
import 'screens/update_todo_screen.dart';

void main() {
  runApp(ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 5, 1, 238),
      ),
      useMaterial3: true,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const TodoListScreen(),
      '/add': (context) => const AddTodoScreen(),
      '/update': (context) => const UpdateTodoScreen(),
    },
  )));
}
