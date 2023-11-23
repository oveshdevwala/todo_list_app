// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_listapp/DataBase/Colors.dart';
import 'package:todo_listapp/DataBase/database.dart';
import 'package:todo_listapp/loginTask/loginScreen.dart';
import 'package:todo_listapp/loginTask/splashScreen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class uicolors {
  static Color appblue = Color(0xff4d65f5);
  static Color textfildlabel = Colors.white;
}

var deleteonclickvalue = false;
var notes = 'Complete NoteApp';
var notesController = TextEditingController();
var EditnotesController = TextEditingController(text: editedNoteText);
var popvalue;
var catagorybtValue = false;
var editedNoteText;
// var catagoryvalue;
var selectedTime;
var catgoryvalue;
// var radioSelection = true;
dynamic noteEditValue;
var noteEditbt;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  var username;
  var email;
  var password;
  @override
  void initState() {
    super.initState();
    prefvalueGetter();
  }

  prefvalueGetter() async {
    var prefs = await SharedPreferences.getInstance();
    var getusername = prefs.getString(ComponentClass.username_pref);
    var getemail = prefs.getString(ComponentClass.email_pref);
    var getpassword = prefs.getString(ComponentClass.password_pref);

    username = getusername!;
    email = getemail!;
    password = getpassword!;
    setState(() {});
  }

  var SelectedCatgoryValue = 'Personal';
  var catgoryList = [
    "Training",
    "Personal",
    'Work',
    'Finance',
    'Shopping',
    'Study',
    'BirthDays'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: uicolor.bgblueColor, elevation: 0, actions: [
        SizedBox(width: 20),
      ]),
      backgroundColor: uicolor.bgblueColor,
      drawer: HomeScreenDrawer(context),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Notestitle(),
            SizedBox(height: 10),
            NotesListView(),
          ]))),
      floatingActionButton: FlottingAddnoteButton(context),
    );
  }

  Text Notestitle() {
    return Text(
      'Notes',
      style: TextStyle(
          fontSize: 30,
          color: uicolors.textfildlabel,
          fontWeight: FontWeight.bold),
    );
  }

  FloatingActionButton FlottingAddnoteButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: uicolor.bgblueColor,
        child: Icon(Icons.add, size: 35),
        onPressed: () {
          bottom_sheet(context);
        });
  }

  Drawer HomeScreenDrawer(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: uicolor.bgblueColor,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 200),
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
                border: Border.all(color: uicolors.textfildlabel, width: 1),
                color: uicolors.appblue,
                shape: BoxShape.circle),
            child: Icon(
              Icons.person_outline_outlined,
              size: 80,
              color: uicolors.textfildlabel,
            ),
          ),
          SizedBox(height: 15),
          Text(
            username.toString(),
            style: TextStyle(
                fontSize: 22,
                color: uicolors.textfildlabel,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 100),
          Container(
              alignment: Alignment.center,
              child: Text(email.toString(),
                  style:
                      TextStyle(fontSize: 20, color: uicolors.textfildlabel))),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setBool(ComponentClass.Login_pref_key, false);
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SplashScreen();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: uicolors.textfildlabel, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: uicolor.bgblueColor,
                  foregroundColor: uicolors.textfildlabel),
              child: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Logout",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.logout_rounded),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Future<dynamic> bottom_sheet(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      backgroundColor: uicolor.bgblueColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Notes',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: uicolors.textfildlabel)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.white,
                        foregroundColor: uicolor.bgblueColor),
                    onPressed: () {
                      var notes = notesController.text.toString();
                      if (notesController.text.isNotEmpty) {
                        NotesData.add({
                          'note': notes,
                          'time': selectedTime,
                          'catagory': SelectedCatgoryValue
                        });
                        Navigator.pop(context);
                        notesController.clear();
                        selectedTime = null;
                        setState(() {});
                      } else {
                        Navigator.pop(context);

                        blankError_DialogBox(context);
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(fontSize: 20),
              controller: notesController,
              decoration: TextFildDecoration(),
            ),
            SizedBox(height: 10),
            // TimerSelector(context),
            // radiobuttoms(0),
            // radiobuttoms(1),
            // radiobuttoms(2),
          ]),
        );
      },
    );
  }

  Future<dynamic> blankError_DialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text("Notes Can't Blank"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        );
      },
    );
  }

  InputDecoration TextFildDecoration() {
    return InputDecoration(
        hintText: 'Type Notes Here',
        hintStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        fillColor: Colors.white.withOpacity(0.7),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none));
  }

  RadioListTile<String> radiobuttoms(index) {
    return RadioListTile(
        title: Text(catgoryList[index]),
        value: catgoryList[index],
        groupValue: SelectedCatgoryValue,
        onChanged: (value) {
          SelectedCatgoryValue = value!;
          catgoryvalue = catgoryList[index];
          setState(() {});
        });
  }

  Container TimerSelector(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: uicolor.bgblueColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () async {
          var selectedTimevalue = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          if (selectedTimevalue != null) {
            selectedTime =
                "${selectedTimevalue.hour}:${selectedTimevalue.minute}";
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Text(
            selectedTime == null ? 'Select Time' : selectedTime,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class NotesListView extends StatefulWidget {
  NotesListView({
    super.key,
  });

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: ListView.builder(
        itemCount: NotesData.length,
        itemBuilder: (context, index) {
          return NotesData[index]['note'] != null
              ? Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              size: 30,
                              color: uicolor.bgblueColor,
                            ),
                            onPressed: () {
                              // deleteonclickvalue = !deleteonclickvalue;

                              NotesData[index]['note'] = null;
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit_note_rounded,
                              size: 35,
                              color: uicolor.bgblueColor,
                            ),
                            onPressed: () {
                              editedNoteText = EditnotesController.text;
                              _editNoteDialog(context, index);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      "${NotesData[index]['note'] == null ? null : NotesData[index]['note']}",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    // subtitle: showSubtitle(index),
                  ))
              : Container();
        },
      ),
    );
  }

  Padding showSubtitle(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        NotesData[index]['time'] == null
            ? ''
            : "Time : ${NotesData[index]['time']} | ${NotesData[index]['catagory']}",
        style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }

  void _editNoteDialog(BuildContext context, var indexP) {
    EditnotesController.text = NotesData[indexP]['note'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: uicolor.bgblueColor,
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Change Current Note",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: EditnotesController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Change Notes',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: uicolor.bgblueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Cancel button logic - simply close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: uicolor.bgblueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Update button logic - get the edited text from EditnotesController
                    // editedNoteText = EditnotesController.text;
                    NotesData[indexP]['note'] = EditnotesController.text;
                    // Process and save the edited note
                    // You can use the 'editedNoteText' as the updated note content
                    // Close the dialog
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  edit_dialogbox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: uicolor.bgblueColor,
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Change Current Note",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: EditnotesController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Change Notes',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: uicolor.bgblueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: uicolor.bgblueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Update",
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
              ],
            ),
          ],
        );
      },
    );
  }
}
