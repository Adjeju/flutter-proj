import 'package:flutter/material.dart';
import 'package:test/custom_widgets/todo_tile.dart';
import 'package:test/pages/home.dart';

class TodoGridView extends StatefulWidget {
  List<TodoItem> todoList;
  Function deleteTask;
  Function editTask;
  int selectedDay;

  TodoGridView(
      {Key? key,
      required this.todoList,
      required this.deleteTask,
      required this.editTask,
      required this.selectedDay})
      : super(key: key);

  @override
  _TodoGridViewState createState() => _TodoGridViewState();
}

class _TodoGridViewState extends State<TodoGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return TodoTile(
            todo: widget.todoList[index],
            deleteTask: widget.deleteTask,
            editTask: widget.editTask,
            selectedDay: widget.selectedDay);
      },
    );
  }
}
