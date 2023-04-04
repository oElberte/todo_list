import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/todo_list_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class TodoListListenerNotifier {
  final TodoListChangeNotifier changeNotifier;

  const TodoListListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    SuccessVoidCallback? successCallback,
    ErrorVoidCallback? errorCallback,
    EverVoidCallback? everCallback,
  }) {
    changeNotifier.addListener(() {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }
      if (changeNotifier.isLoading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        if (successCallback != null) {
          successCallback(changeNotifier, this);
        }
      }
    });
  }
}

typedef SuccessVoidCallback = void Function(
  TodoListChangeNotifier notifier,
  TodoListListenerNotifier listenerInstance,
);

typedef ErrorVoidCallback = void Function(
  TodoListChangeNotifier notifier,
  TodoListListenerNotifier listenerInstance,
);

typedef EverVoidCallback = void Function(
  TodoListChangeNotifier notifier,
  TodoListListenerNotifier listenerInstance,
);
