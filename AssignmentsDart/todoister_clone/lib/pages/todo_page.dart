import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:todoister_clone/Database/database_helper.dart';
import 'package:todoister_clone/Database/db_utils.dart';
import 'package:todoister_clone/model/todo.dart';

class TodoPage extends StatefulWidget {
  final String buttonTextValue;
  final Todo? todoItem;

  TodoPage({Key? key, required this.buttonTextValue, required this.todoItem})
      : super(key: key);

  @override
  State<TodoPage> createState() => TodoPageState(buttonTextValue, todoItem);
}

const List<String> priorityList = ['LOW', 'MEDIUM', 'HIGH'];

class TodoPageState extends State<TodoPage> {
  // DatabaseHelper dbHelper = DatabaseHelper();
  final String _buttonTextValue;
  final Todo? todoItem;
  TodoPageState(this._buttonTextValue, this.todoItem);

  TextEditingController todoTitleController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  // final todoListProvider = Provider()

  @override
  Widget build(BuildContext context) {
    if (todoItem != null) {
      todoTitleController.text = todoItem!.todoTitle;
      priorityController.text = todoItem!.todoPriority;
      deadlineController.text = todoItem!.todoDeadline;

      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo-list',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                padding: EdgeInsets.all(4),
                child: TextField(
                  controller: todoTitleController,
                  keyboardType: TextInputType.name,
                  maxLength: 35,
                  maxLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.today_outlined,
                        color: Colors.blueAccent,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              width: 4,
                              style: BorderStyle.solid,
                              color: Colors.deepPurpleAccent)),
                      labelText: 'TodoTitle',
                      hintText: 'Eg: Running , Gymming ..'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: TextField(
                        controller: deadlineController,
                        onTap: () async {
                          displayDatePickerUI(context);
                        },
                        keyboardType: TextInputType.none,
                        maxLines: 1,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.date_range_outlined,
                            size: 20,
                            color: Colors.deepOrange,
                          ),
                          hintText: 'Eg : 10-1-2023',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 4,
                                  style: BorderStyle.solid,
                                  color: Colors.deepOrange)),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.indigo),
                                borderRadius: BorderRadius.circular(12)),
                            child: DropdownMenu<String>(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              controller: priorityController,
                              initialSelection: priorityList.first,
                              dropdownMenuEntries: priorityList
                                  .map<DropdownMenuEntry<String>>((itemValue) {
                                return DropdownMenuEntry<String>(
                                    leadingIcon: Icon(
                                      Icons.circle,
                                      color: getColorByPriorityType(itemValue),
                                      size: 20,
                                    ),
                                    label: itemValue,
                                    value: itemValue);
                              }).toList(),
                            )))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                padding: EdgeInsets.all(4),
                width: MediaQuery.of(context).size.width,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      String todoTitle = todoTitleController.text;
                      String todoPriority = priorityController.text;
                      String todoTime = deadlineController.text;

                      if (notCheckEmpty_Nullable(todoTime) &&
                          notCheckEmpty_Nullable(todoPriority) &&
                          notCheckEmpty_Nullable(todoTitle)) {
                        if (_buttonTextValue == 'Save') {
                          saveTodoIntoDatabase(
                              context, todoTitle, todoPriority, todoTime!);
                        } else if (_buttonTextValue == 'Update' &&
                            todoItem != null) {
                          updateTodoIntoDatabase(context, todoTitle,
                              todoPriority, todoTime, todoItem!);
                        }
                      }
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      '${this._buttonTextValue}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  bool notCheckEmpty_Nullable(String asset) {
    //default value of textEditiingcontroller is alaways empty
    if (asset != null && asset.isNotEmpty) return true;
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todoTitleController.dispose();
    priorityController.dispose();
    deadlineController.dispose();

    super.dispose();

    DatabaseRepository().closeDatabaseLayer();
  }

  Future<void> displayDatePickerUI(BuildContext context_) async {
    DateTime? newDateTime = await showDatePicker(
        context: context_,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        currentDate: DateTime.now(),
        confirmText: 'Confirm',
        cancelText: 'Cancel',
        lastDate: DateTime(DateTime.now().year + 1));

    final currTime = DateTime.now();
    setState(() {
      if (newDateTime != null) {
        String tempVariable = DateFormat.yMMMd().format(newDateTime!);

        if (newDateTime.day == currTime.day &&
            newDateTime.month == currTime.month &&
            newDateTime.year == currTime.year) {
          deadlineController.text = 'Today';
        } else if (newDateTime.day == currTime.day + 1 &&
            newDateTime.month == currTime.month &&
            newDateTime.year == currTime.year) {
          deadlineController.text = 'Tomorrow';
        } else {
          deadlineController.text = tempVariable;
        }
      } else {
        //if its null , then its provides current date time.
        deadlineController.text = DateFormat.yMMMd().format(DateTime.now());
      }
    });
  }

  void updateTodoIntoDatabase(BuildContext context, String title,
      String priority, String deadline, Todo currTodo) async {
    try {
      await DatabaseRepository()
          .updateTodoList(todoItem!.todoID, title, deadline, priority);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Updated your todoItem!'),
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  void saveTodoIntoDatabase(BuildContext context, String title, String priority,
      String deadline) async {
    Todo todoItem = Todo(title, deadline, priority);
    await DatabaseRepository().insertTodo(todoItem);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(' saved'),
      duration: Duration(seconds: 3),
    ));

    // List<Todo> list = await dbHelper.getAllTodoList();
    List<Todo> list = await DatabaseRepository().getAllTodoList();
    debugPrint(list.length.toString());
    list.forEach((element) {
      print(
          '${element.todoTitle} - ${element.todoID} - ${element.todoDeadline}');
    });
  }

  Color getColorByPriorityType(String priority) {
    if (priority == 'LOW') {
      return Colors.green;
    } else if (priority == 'MEDIUM') {
      return Colors.indigo;
    }
    return Colors.red;
  }

  DateTime ToDateTimeFromString(String dateTimeItem) {
    final dateFormat = DateFormat('yMd').parse(dateTimeItem);
    return dateFormat;
  }
}
