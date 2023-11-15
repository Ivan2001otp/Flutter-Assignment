import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:sechluder/Utils/Utility.dart';
// import 'package:intl/intl.dart';

class ToDoPlannerPage extends StatefulWidget {
  const ToDoPlannerPage({super.key});

  @override
  State<ToDoPlannerPage> createState() => _ToDoPlannerPageState();
}

const List<String> Am_Pm_List = <String>['AM', 'PM'];

const List<String> dropDownListItems = <String>[
  'Set Priority Level',
  'LOW',
  'MEDIUM',
  'HIGH'
];

class _ToDoPlannerPageState extends State<ToDoPlannerPage> {
  String selectedDropDownValue = dropDownListItems.first;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  String? selectedPriorityLevel;
  String? userDescription;
  String? userTodoTitle;

  //initializing the controllers.
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDateController = TextEditingController();
  TextEditingController todoTimeController = TextEditingController();
  TextEditingController todoDescriptionController = TextEditingController();
  TextEditingController todoPriorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Todo-Planner',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                  child: TextField(
                    controller: todoTitleController,
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                      
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(201, 96, 8, 218),
                                style: BorderStyle.solid)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Todo - Title',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.title_rounded,
                          color: Colors.black,
                        ),
                        hintText: 'Gymming , Studying,..',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(236, 151, 150, 150))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: todoDateController,
                          onTap: () async {
                            displayDatePickerUI(context);
                          },
                          keyboardType: TextInputType.none,
                          maxLines: 1,
                          decoration: customTextFieldDecoration(
                              hintText_: '4 Jun ,Tue',
                              labelText_: 'Date',
                              prefixIconData: Icons.calendar_month_outlined,
                              prefixIconColor_:
                                  Color.fromARGB(255, 199, 22, 9)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: todoTimeController,
                          onTap: () async {
                            displayTimePickerUI(context);
                          },
                          keyboardType: TextInputType.none,
                          maxLines: 1,
                          decoration: customTextFieldDecoration(
                              hintText_: '12:30 ..',
                              labelText_: 'Time',
                              prefixIconData: Icons.timer,
                              prefixIconColor_:
                                  const Color.fromARGB(255, 15, 146, 20)),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 25, left: 8, right: 8),
                        alignment: Alignment.center,
                        child: DropdownMenu<String>(
                          controller: todoPriorityController,
                          trailingIcon: Icon(
                            Icons.priority_high_rounded,
                            color: Colors.redAccent,
                          ),
                          width:
                              MediaQuery.of(context).size.width * (1 / 2) + 5,
                          menuStyle: MenuStyle(
                              alignment: Alignment.centerLeft,
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder?>((Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15));
                                } else {
                                  return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          width: 2, color: Colors.deepPurple));
                                }
                              })),
                          initialSelection: dropDownListItems.first,
                          dropdownMenuEntries: dropDownListItems
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                trailingIcon: setPriorityIcon(value),
                                value: value,
                                label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: false,
                      child: Expanded(
                          child: Container(
                        margin: EdgeInsets.only(top: 35, left: 15, right: 0),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * (1 / 2) + 30,
                        child: DropdownMenu<String>(
                          trailingIcon: Icon(
                            Icons.add_alert_sharp,
                            color: Colors.deepPurpleAccent,
                          ),
                          initialSelection: Am_Pm_List.first,
                          width: MediaQuery.of(context).size.width * (1 / 4),
                          dropdownMenuEntries:
                              Am_Pm_List.map<DropdownMenuEntry<String>>(
                                  (String value_) {
                            return DropdownMenuEntry<String>(
                                trailingIcon: setPriorityIcon(value_),
                                value: value_,
                                label: value_);
                          }).toList(),
                        ),
                      )),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 8, right: 8),
                  child: TextField(
                    controller: todoDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 100,
                    decoration: customTextFieldDecoration(
                        hintText_: 'Consistent Workout & Diet focus...',
                        labelText_: 'Description',
                        prefixIconData: Icons.description_outlined,
                        prefixIconColor_: Colors.blue),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width) * (3 / 4),
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          onUpdateSaveHandler(this.context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            )),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ),
                )
              ],
            )));
  }

  InputDecoration customTextFieldDecoration(
      {hintText_, labelText_, prefixIconData, prefixIconColor_}) {
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: Color.fromARGB(201, 96, 8, 218))),
        hintText: hintText_,
        labelText: labelText_,
        prefixIcon: Icon(
          prefixIconData,
          color: prefixIconColor_,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          fontSize: 15,
          color: Color.fromARGB(236, 151, 150, 150),
        ));
  }

  Widget setPriorityIcon(String value) {
    dynamic priorityIconType = Icons.pix_rounded;
    switch (value) {
      case 'HIGH':
        Icon icon = Icon(
          Icons.ac_unit,
          color: Colors.red,
          size: 30,
        );
        priorityIconType = icon;
        break;

      case 'LOW':
        Icon icon = Icon(
          Icons.ac_unit,
          color: Colors.blue,
          size: 30,
        );
        priorityIconType = icon;
        break;

      case 'MEDIUM':
        Icon icon = Icon(
          Icons.ac_unit,
          color: Colors.orange,
          size: 30,
        );
        priorityIconType = icon;
        break;

      case 'AM':
        Icon icon = Icon(
          Icons.wb_sunny_rounded,
          color: Colors.deepOrange,
          size: 30,
        );
        priorityIconType = icon;
        break;

      case 'PM':
        Icon icon = Icon(
          Icons.nightlight,
          color: const Color.fromARGB(255, 33, 65, 243),
        );
        priorityIconType = icon;
        break;

      default:
        Icon icon = Icon(
          Icons.ac_unit,
          color: Color.fromARGB(255, 9, 52, 181),
          size: 30,
        );
        priorityIconType = icon;
    }
    return priorityIconType;
  }

  Future<void> displayTimePickerUI(BuildContext context_) async {
    TimeOfDay? timePicker = await showTimePicker(
      context: context_,
      orientation: Orientation.portrait,
      errorInvalidText: 'Invalid',
      initialTime: selectedTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    //selectedTime = timePicker;

    if (timePicker != null) {
      /*final DateTime dt = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, timePicker.hour, timePicker.minute);
      setState(() {
        todoTimeController.text = dt.toLocal().toString().split(" ")[0];
      });*/

      // ignore: use_build_context_synchronously
      debugPrint(timePicker.format(context_).toString());

      //convert TimeDay? to DateTime
      DateTime parsedTime =
          DateFormat.Hm().parse(timePicker.format(context_).toString());

      String formattedTime = DateFormat('HH:mm a').format(parsedTime);

      debugPrint('Formated time ${formattedTime}\n');
      selectedTime = Utility.StringtoTimeOfDay(formattedTime);
/*
      String temp = selectedTime.toString();
      temp = temp.substring(10, temp.length - 1);
      */
      todoTimeController.text = formattedTime;

      debugPrint('selected time is ${selectedTime.toString()}\n');
    } else {
      todoTimeController.text = 'Error';
      debugPrint('selected time is NULL\n');
    }

    // debugPrint('selected time is ${timepicker}\n');
  }

  Future<void> displayDatePickerUI(BuildContext context_) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context_,
      styleDatePicker: MaterialRoundedDatePickerStyle(
        backgroundHeader: Colors.white,
        textStyleDayButton: TextStyle(fontSize: 36, color: Colors.white),
        textStyleYearButton: TextStyle(
          fontSize: 52,
          color: Colors.white,
        ),
        textStyleDayHeader: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),

        // textStyleDayOnCalendar: TextStyle(fontSize: 28, color: Colors.white),
        textStyleDayOnCalendarSelected: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: DateTime.now(),
      borderRadius: 16,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      imageHeader: AssetImage("images/Pngs/riccardo.jpg"),
    );

    selectedDate = newDateTime;
    var currentDate = DateTime.now();
    //debugPrint(selectedDate.toString().substring(0, 11));

    setState(() {
      if (selectedDate != null) {
        String tempSelectedDate = DateFormat.yMMMd().format(selectedDate!);

        if (selectedDate?.day == currentDate.day &&
            selectedDate?.month == currentDate.month &&
            selectedDate?.year == currentDate.year) {
          todoDateController.text = 'Today';
        } else if (selectedDate?.day == currentDate.day + 1 &&
            selectedDate?.month == currentDate.month &&
            selectedDate?.year == currentDate.year) {
          todoDateController.text = 'Tomorrow';
        } else {
          todoDateController.text = tempSelectedDate;
        }
      } else {
        todoDateController.text = 'Invalid !';
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todoDateController.dispose();
    todoTimeController.dispose();
    todoTitleController.dispose();
    super.dispose();
  }

  void onUpdateSaveHandler(BuildContext context_) {
    debugPrint('save button clicked!');
    userTodoTitle = todoTitleController.text;
    selectedPriorityLevel = todoPriorityController.text;
    userDescription = todoDescriptionController.text;

    WidgetsFlutterBinding.ensureInitialized();

    if (userDescription != null &&
        selectedPriorityLevel != null &&
        userTodoTitle != null &&
        selectedDate != null &&
        selectedTime != null &&
        selectedPriorityLevel != 'Set Priority Level') {
      debugPrint('save button clicked - if loop !');
      debugPrint(
          'todo Title = ${userTodoTitle}\n selectedDate - ${selectedDate}\n selectedTime - ${selectedTime}\n userdesc - ${userDescription}\n priority - ${selectedPriorityLevel}');

      //  Navigator.pop(context_,settings : RouteSettings())
      ScaffoldMessenger.of(context_).showSnackBar(SnackBar(
        content: Text(
          'Done saved!',
          style: TextStyle(fontSize: 15),
        ),
        duration: Duration(seconds: 2),
        //margin: EdgeInsets.only(right: 10, left: 10, bottom: 30)
        width: 400,
        padding: const EdgeInsets.all(4),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      debugPrint('save button clicked! - else loop');

      ScaffoldMessenger.of(context_).showSnackBar(const SnackBar(
        content: Text(
          'Went wrong!',
          style: TextStyle(fontSize: 15),
        ),
        duration: Duration(seconds: 2),
        width: 400,
        // margin: EdgeInsets.only(right: 10, left: 10, bottom: 30),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(4),
      ));
    }
  }
}
