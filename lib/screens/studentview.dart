import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_weekfive/function/db_function.dart';
import 'package:main_weekfive/model/studentmodel.dart';

class SingleStudentView extends StatelessWidget {
  const SingleStudentView({super.key, required this.singlestudent});
  final StudentModel singlestudent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student View'),
        ),
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: studentListnotifier,
              builder: (BuildContext context, List<StudentModel> studentlist,
                  Widget? child) {
                return Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 500,
                          child: Card(
                            elevation: 40,
                            child: Column(
                              children: [const SizedBox(height: 30,),
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: FileImage(File(singlestudent.image)),
                                ),
                                const SizedBox(height: 15,),
                                Text(singlestudent.name,style: const TextStyle(fontSize: 40,color: Color.fromARGB(179, 0, 0, 0)),),
                                 const SizedBox(width: 8,),
                                                              Text( singlestudent.age, style:const TextStyle(fontSize: 40,color: Color.fromARGB(179, 0, 0, 0), ),),
                               const SizedBox(height: 15,),
                               Text(singlestudent.address, style:const TextStyle(fontSize: 40,color: Color.fromARGB(179, 0, 0, 0)),),
                               
                               const SizedBox(height: 15,),
                               Text(singlestudent.domain, style:const TextStyle(fontSize: 40,color: Color.fromARGB(179, 0, 0, 0)),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ));
  }
}
