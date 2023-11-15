import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  //constructor
  NoteDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailState(this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static final _priorities = ['High', 'Low'];
  String appBarTitle;

  //controllers of text
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle ts = Theme.of(context).textTheme.titleMedium!;

    // TODO: implement build
    return WillPopScope(
      onWillPop: () => moveToPreviousScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              moveToPreviousScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              //first element
              ListTile(
                title: DropdownButton(
                  hint: const Text(
                    'Select Priority',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300),
                  ),
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem));
                  }).toList(),
                  onChanged: (selectedDropDownItem) {
                    setState(() {
                      debugPrint('User selected $selectedDropDownItem');
                    });
                  },
                  style: ts,
                ),
              ),

              //second element
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: titleController,
                  style: ts,
                  onChanged: (value) {
                    debugPrint('Something in title text field!');
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: ts,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              //third element
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: descriptionController,
                  style: ts,
                  onChanged: (value) {
                    debugPrint('someting in desc text field changed!');
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: ts,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            textStyle: MaterialStateProperty.all(ts),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textScaleFactor: 1.5,
                          maxLines: 1,
                        )),
                  ),
                  Container(
                    width: 8.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            textStyle: MaterialStateProperty.all(ts),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {},
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textScaleFactor: 1.5,
                          maxLines: 1,
                        )),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> moveToPreviousScreen() async {
    Navigator.pop(context);
    return true;
  }
}
