import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';

class HomeCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasks;
  final bool selected;

  const HomeCardFilter({
    super.key,
    required this.label,
    required this.taskFilter,
    required this.selected,
    this.totalTasks,
  });

  double _getPercentFinish() {
    final total = totalTasks?.tasks ?? 0.0;
    final totalFinish = totalTasks?.tasksFinished ?? 0.1;

    if (total == 0) {
      return 0;
    }

    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? context.primaryColor : Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(.8),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${totalTasks?.tasks ?? 0} TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0,
              end: _getPercentFinish(),
            ),
            duration: const Duration(seconds: 1),
            builder: (_, value, __) {
              return LinearProgressIndicator(
                backgroundColor: selected ? context.primaryColorLight : Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(selected ? Colors.white : context.primaryColor),
                value: value,
              );
            },
          ),
        ],
      ),
    );
  }
  
}
