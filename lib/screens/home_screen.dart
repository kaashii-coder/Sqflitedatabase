import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_weekfive/function/db_function.dart';
import 'package:main_weekfive/model/studentmodel.dart';
import 'package:main_weekfive/screens/addstudent_screen.dart';
import 'package:main_weekfive/screens/editstudent.dart';
import 'package:main_weekfive/screens/studentview.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController _seachController = TextEditingController();
  String _searchText = '';
  bool isgridmode = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students Record'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isgridmode = !isgridmode;
                });
              },
              icon: isgridmode
                  ? const Icon(Icons.grid_view_rounded)
                  : const Icon(Icons.format_list_numbered))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddStudent_Screen()));
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListnotifier,
        builder: (BuildContext context, List<StudentModel> studentlist,
            Widget? child) {
          return isgridmode
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _seachController,
                        onChanged: (value) {
                          getsearchDetails(_seachController.text);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Seach'),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            final data = studentlist;
                            return Card(
                              child: SingleChildScrollView(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SingleStudentView(
                                              singlestudent: data[index],
                                            )));
                                  },
                                  title: Text(data[index].name),
                                  subtitle: Text(studentlist[index].age),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditStudent_Screen(
                                                              editstudentModel:
                                                                  data[index])));
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              alerting(data[index].id);
                                            },
                                            icon: Icon(Icons.delete)),
                                      ],
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(data[index].image)),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: studentlist.length),
                    ),
                  ],
                )
              : GridView.builder(
                  itemCount: studentlist.length,
                  
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    
                    final data = studentlist;
                    return SingleChildScrollView (
                      child: GestureDetector(
                        onTap: () {
                           Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SingleStudentView(
                                              singlestudent: data[index],
                                            )));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(File(data[index].image)),
                              )),
                              SizedBox(
                                height: 8,
                              ),
                              Text(data[index].name),
                              SizedBox(
                                height: 8,
                              ),
                              Text(data[index].age),
                              SizedBox(
                                width: 130,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditStudent_Screen(
                                                        editstudentModel:
                                                            data[index])));
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                        onPressed: () {alerting(data[index].id);}, icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  alerting(id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    deleteAstudent(id);
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  getsearchDetails(String s) async {
    _seachController.text = s;
    await searchIteams(s);
  }
}
