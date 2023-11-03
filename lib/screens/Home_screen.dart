import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_listapp/DataBase/Colors.dart';
import 'package:todo_listapp/DataBase/database.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

var deleteonclickvalue = false;
var notes = 'Complete NoteApp';
var notesController = TextEditingController();
var popvalue;
var catagorybtValue = false;
// var catagoryvalue;
var selectedTime;
var catgoryvalue;
// var radioSelection = true;

class _Home_ScreenState extends State<Home_Screen> {
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
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.list_bullet)),
        SizedBox(width: 20),
      ]),
      backgroundColor: uicolor.bgblueColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notes',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          NotesListView()
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: uicolor.bgblueColor,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              backgroundColor: uicolor.bgblueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              context: context,
              builder: (context) {
                return Container(
                  // height: 1000,
                  padding: EdgeInsets.all(20),
                  // color: uicolor.bgblueColor.withOpacity(0.8),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add Notes',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
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
                                // popvalue = true;
                                Navigator.pop(context);

                                showDialog(
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
                      style: TextStyle(fontSize: 18),
                      controller: notesController,
                      decoration: InputDecoration(
                          hintText: 'Type Notes',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          fillColor: Colors.white.withOpacity(0.7),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none)),
                    ),
                    SizedBox(height: 10),
                    Container(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          child: Text(
                            selectedTime == null ? 'Select Time' : selectedTime,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    RadioListTile(
                        title: Text(catgoryList[0]),
                        value: catgoryList[0],
                        groupValue: SelectedCatgoryValue,
                        onChanged: (value) {
                          SelectedCatgoryValue = value!;
                          catgoryvalue = catgoryList[0];
                          setState(() {});
                        }),
                    RadioListTile(
                        title: Text(catgoryList[1]),
                        value: catgoryList[1],
                        groupValue: SelectedCatgoryValue,
                        onChanged: (value) {
                          SelectedCatgoryValue = value!;
                          catgoryvalue = catgoryList[1];
                          setState(() {});
                        }),
                    RadioListTile(
                        title: Text(catgoryList[2]),
                        value: catgoryList[2],
                        groupValue: SelectedCatgoryValue,
                        onChanged: (value) {
                          SelectedCatgoryValue = value!;
                          catgoryvalue = catgoryList[1];
                          setState(() {});
                        }),
                  ]),
                );
              },
            );
          }),
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
                  // height: 120,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    trailing: IconButton(
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
                    title: Text(
                      "${NotesData[index]['note'] == null ? null : NotesData[index]['note']}",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        NotesData[index]['time'] == null
                            ? ''
                            : "Time : ${NotesData[index]['time']} | ${NotesData[index]['catagory']}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ))
              : Container();
        },
      ),
    );
  }
}
