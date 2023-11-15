import 'dart:ffi';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:project_task_scheduler_1/Model/Note.dart';
import 'package:project_task_scheduler_1/Screens/note_detail.dart';
import 'package:project_task_scheduler_1/Utils/DatabaseHelper.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNotesListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          NavigationHelper('Add-Note');
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNotesListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: ((context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            onTap: () {
              debugPrint('Item clicked!');
              NavigationHelper('Update-Note');
            },
            title: Text(this.noteList[index].title),
            subtitle: Text(this.noteList[index].date),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.black12),
              onTap: () {
                debugPrint('deleted ');
                _delete(context, noteList[index]);
              },
            ),
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[index].priority),
              child: getPriorityIcon(this.noteList[index].priority),
            ),
          ),
        );
      }),
    );
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar(context, 'Note deleted!');
      //update the list view
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(message),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();

      noteListFuture.then((notelist) {
        this.noteList = notelist;
        this.count = notelist.length;
      });
    });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;

      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;

      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
        break;
    }
  }

  void NavigationHelper(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    }));
  }
}
