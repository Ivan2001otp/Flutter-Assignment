import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:todoister_clone/Database/database_helper.dart';
import 'package:todoister_clone/Database/db_utils.dart';
import 'package:todoister_clone/pages/todo_page.dart';
import './pages/todo_page.dart';
import './model/todo.dart';

void main() {
  runApp(ProviderScope(
      child: MaterialApp(
    home: (HomePage()),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  )));
}

final todoFutureProvider = FutureProvider<List<Todo>>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  debugPrint('hit db');

  return await DatabaseRepository().getAllTodoList();
});

class HomePage extends ConsumerStatefulWidget {
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 22,
          ),
          onPressed: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TodoPage(
                          todoItem: null,
                          buttonTextValue: 'Save',
                        )));
            // progressBarProvider.overrideWithValue(true);

            try {
              if (result) {
                // await Future.delayed(const Duration(seconds: 3));
                ref.refresh(todoFutureProvider).when(
                    data: (_data) {
                      debugPrint('refreshing : ' + _data.length.toString());
                    },
                    error: ((error, stackTrace) => {}),
                    loading: () {
                      CircularProgressIndicator(
                        color: Colors.green,
                      );
                    });
                // progressBarProvider.overrideWithValue(false);
              }
              print(result);
            } catch (e) {
              print(e.toString());
            }
          }),
      appBar: AppBar(
        elevation: 0,
        title: Text('Todoister'),
      ),
      body: ref.watch(todoFutureProvider).when(data: (responseList) {
        return ListView.builder(
            itemBuilder: ((context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        width: 3,
                        color: getColorByPriorityType(
                            responseList[index].todoPriority))),
                child: ListTile(
                  onTap: () async {
                    try {
                      bool updateStatus = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TodoPage(
                                  todoItem: responseList[index],
                                  buttonTextValue: 'Update')));

                      if (updateStatus) {
                        ref.refresh(todoFutureProvider);
                      }
                    } catch (e) {}
                  },
                  subtitle: Text(
                    responseList[index].todoDeadline,
                    style: TextStyle(),
                  ),
                  leading: Icon(
                    Icons.circle,
                    size: 20,
                    color: getColorByPriorityType(
                        responseList[index].todoPriority),
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        debugPrint(
                            'clicked ' + responseList[index].todoID.toString());

                        var dbInstance = DatabaseRepository();
                        int res = await dbInstance
                            .deleteTodoList(responseList[index].todoID);
                        print('Changes after delete : $res');

                        if (res > 0) {
                          // Future.delayed(const Duration(seconds: 1),(){});
                          ref.refresh(todoFutureProvider);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${responseList[index].todoTitle} deleted'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                        size: 35,
                      )),
                  title: Text(responseList[index].todoTitle),
                ),
              );
            }),
            itemCount: responseList.length);
      }, error: (_error, _stackTrace) {
        return Center(
          child: Text(_error.toString()),
        );
      }, loading: () {
        Ticker((elapsed) {
          print(elapsed.inSeconds.toString());
        });
        debugPrint('executing loading-- ');
        Ticker(((elapsed) {
          print(elapsed.inSeconds.toString());
        }));
        return Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      }),
    );
  }

  Color getColorByPriorityType(String priority) {
    if (priority == 'LOW') {
      return Colors.green;
    } else if (priority == 'MEDIUM') {
      return Colors.indigo;
    }
    return Colors.red;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // DatabaseRepository().closeDatabaseLayer();
  }
}

//observer for showing progress bar.
class ProgressProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }
}
