import 'package:flutter/material.dart';
import 'package:test/custom_widgets/todo_information_popup.dart';
import 'package:test/pages/home.dart';

class TodoTile extends StatefulWidget {
  final TodoItem todo;
  final Function deleteTask;
  final Function editTask;
  final int selectedDay;

  const TodoTile(
      {Key? key,
      required this.todo,
      required this.deleteTask,
      required this.editTask,
      required this.selectedDay})
      : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      height: 200,
      width: 250,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => widget.deleteTask(widget.todo.id),
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return TodoInformationPopup(
                                titleController: titleController,
                                descriptionController: descriptionController,
                              );
                            }).then((value) {
                          widget.editTask(TodoItem(
                              id: widget.todo.id,
                              day: widget.selectedDay,
                              title: titleController.text,
                              description: descriptionController.text));
                        }),
                    icon: const Icon(Icons.edit)),
              ],
            ),
            Text(
              widget.todo.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.todo.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
