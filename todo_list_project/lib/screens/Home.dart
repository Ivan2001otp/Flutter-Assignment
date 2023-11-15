import 'package:flutter/material.dart';
import 'package:todo_list_project/constants/colors.dart';
import '../widgets/ToDoItem.dart';
import '../model/Todo.dart';

class Home extends StatefulWidget {
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final todoList = Todo.todoListRepo();
  final _todoController = TextEditingController();

  void handler(Todo todo) {
    setState(() {
      todo.isDone = !(todo.isDone!!);
    });
  }

  void deleteFunction(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
      const deleteSnackBar = SnackBar(
        content: Text('Deleted todo item!'),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Deleted todo Item!')));
    });
  }

  void addItemTodo(String todoTask) {
    todoList.add(Todo(
        id: DateTime.now().microsecondsSinceEpoch.toString(), task: todoTask));

    const snackBar = SnackBar(
      content: Text('Saved todo item!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    _todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar_Generator(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                SearchBar_Generator(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 15),
                      child: Text(
                        'To-Doister',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 40,
                            color: const Color.fromARGB(255, 47, 12, 145)),
                      ),
                    ),
                    for (Todo todo_obj in todoList)
                      ToDoItem(
                        obj: todo_obj,
                        onToDoChanged: handler,
                        onDeleteItem: deleteFunction,
                      ),
                  ],
                ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    margin: EdgeInsets.only(bottom: 20, right: 10, left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your task here !',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      addItemTodo(_todoController.text);
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        elevation: 10,
                        minimumSize: const Size(60, 60)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget SearchBar_Generator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: tdGrey),
          prefixIconConstraints: BoxConstraints(maxHeight: 15, minWidth: 30),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
    );
  }

  AppBar AppBar_Generator() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          size: 30,
          color: tdBlack,
        ),
        Container(
          width: 40,
          height: 40,
          child: ClipRRect(
            child: Image.asset('assets/images/personal_image.jpg'),
            borderRadius: BorderRadius.circular(40),
          ),
        )
      ]),
    );
  }
}
