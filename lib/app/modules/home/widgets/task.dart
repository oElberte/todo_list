import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

import '../../../models/task_model.dart';

class Task extends StatelessWidget {
  final TaskModel model;

  const Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: model.finished,
            onChanged: (value) =>
                context.read<HomeController>().checkOrUncheckTask(model),
          ),
          title: Text(
            model.description,
            style: TextStyle(
              decoration: model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
              decoration: model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          onLongPress: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text(
                  'Deseja excluir essa task?',
                  style: context.titleStyle.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      var asyncContext = Navigator.of(context);
                      await context.read<HomeController>().deleteTask(model);
                      asyncContext.pop();
                    },
                    child: Text(
                      'Sim',
                      style: context.titleStyle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text(
                      'Não',
                      style: context.titleStyle.copyWith(
                        color: const Color(0xff5C77CE),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
        ),
      ),
    );
  }
}
