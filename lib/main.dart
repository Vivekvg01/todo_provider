import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/pages/todo_pages.dart';
import 'package:todo_provider/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(
          update:
              (BuildContext context, TodoList todoList, ActiveTodoCount? _) =>
                  ActiveTodoCount(todoList: todoList),
        ),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          update: (BuildContext context, TodoFilter todoFilter,
                  TodoSearch todoSearch, TodoList todoList, FilteredTodos? _) =>
              FilteredTodos(
            todoList: todoList,
            todoFilter: todoFilter,
            todoSearch: todoSearch,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosPage(),
      ),
    );
  }
}
