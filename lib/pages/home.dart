import 'package:flutter/material.dart';
import 'package:test/custom_widgets/horizontal_day_list.dart';
import 'package:test/custom_widgets/todo_grid_view.dart';
import 'package:test/custom_widgets/todo_information_popup.dart';

class TodoItem {
  int id;
  int day;
  String title;
  String description;

  TodoItem(
      {required this.day,
      required this.title,
      required this.description,
      required this.id});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<TodoItem> todos = [];

  int selectedDay = 0;

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      value,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.redAccent),
    )));
  }

  void changeWeekday(int day) {
    setState(() {
      selectedDay = day;
    });
  }

  void deleteTask(
    int id,
  ) {
    setState(() {
      todos = todos.where((element) => element.id != id).toList();
    });
  }

  void editTask(TodoItem todo) {
    dynamic newTodos = todos.map((el) => el.id == todo.id ? todo : el).toList();

    setState(() {
      todos = newTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
        title: const Text("MY TODOS"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          HorizontalDayList(
              dayUpdateFunction: changeWeekday, selectedDay: selectedDay),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [BoxShadow(blurRadius: 10.0)]),
              child: TodoGridView(
                  todoList: todos
                      .where((element) => element.day == selectedDay)
                      .toList(),
                  deleteTask: deleteTask,
                  editTask: editTask,
                  selectedDay: selectedDay),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return TodoInformationPopup(
                  titleController: titleController,
                  descriptionController: descriptionController,
                );
              }).then((value) {
            setState(() {
              if (descriptionController.text == "" ||
                  titleController.text == "") {
                showInSnackBar("Title or description can't be empty!");
              } else {
                todos.add(TodoItem(
                    id: DateTime.now().millisecondsSinceEpoch,
                    day: selectedDay,
                    title: titleController.text,
                    description: descriptionController.text));
                titleController.clear();
                descriptionController.clear();
              }
            });
          });
        },
        splashColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
