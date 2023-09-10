import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  const FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos {
  final TodoList todoList;
  final TodoFilter todoFilter;
  final TodoSearch todoSearch;

  FilteredTodos({
    required this.todoList,
    required this.todoFilter,
    required this.todoSearch,
  });
  FilteredTodosState get state {
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
          .toList();
    }

    return FilteredTodosState(filteredTodos: _filteredTodos);
  }
}
