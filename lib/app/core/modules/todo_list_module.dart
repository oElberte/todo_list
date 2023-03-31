import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routes;
  final List<SingleChildWidget>? _bindings;

  /* The constructor is being initialized this way is to prevent anyone outside
  the class to have access to the data */
  const TodoListModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routes,
  })  : _routes = routes,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routes {
    return _routes.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }

  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _routes[path];

    if (widgetBuilder != null) {
      return TodoListPage(
        page: widgetBuilder,
        bindings: _bindings,
      );
    }

    throw Exception();
  }
}
