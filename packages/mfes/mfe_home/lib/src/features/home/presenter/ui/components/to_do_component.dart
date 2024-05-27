import 'package:flutter/material.dart';
import 'package:mfe_shared/mfe_shared.dart';

class ToDoComponent extends StatelessWidget {
  final ToDoEntity toDo;
  final void Function(DismissDirection)? onDismissed;
  final void Function(bool?)? onChanged;
  const ToDoComponent({
    super.key,
    required this.toDo,
    this.onDismissed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(toDo.title),
        subtitle: Text(toDo.description),
        trailing: Checkbox(
          value: toDo.isCompleted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
