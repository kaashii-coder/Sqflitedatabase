import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_weekfive/function/db_function.dart';
import 'package:main_weekfive/model/studentmodel.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent_Screen extends StatefulWidget {
  AddStudent_Screen({super.key});

  @override
  State<AddStudent_Screen> createState() => _AddStudent_ScreenState();
}

class _AddStudent_ScreenState extends State<AddStudent_Screen> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _domaincontroller = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 219, 172),
        title: const Text('Add Student Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image != null && _image!.path.isNotEmpty
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(_image!.path)))
                        : const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('Asset/th.jpeg'),
                          ),
                    IconButton(
                        onPressed: () {
                          uploadImage();
                        },
                        icon: const Icon(Icons.add_a_photo_outlined))
                  ],
                ),
                TextFormField(
                  controller: _namecontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r'^[0-9]+$'),
                        allow: true)
                  ],
                  controller: _agecontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "Age",
                      hintText: "Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter age';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _addresscontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Address and Pincode",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your address' : null,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _domaincontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "Domain",
                      hintText: "Domain",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Please enter your Domain",
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 5, 219, 172)),
                    onPressed: () {
                      adddetailsbuttonclicked();
                    },
                    child: const Text('Add Details'),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 5, 219, 172)),
                    onPressed: () {
                      _namecontroller.clear();
                      _agecontroller.clear();
                      _addresscontroller.clear();
                      _domaincontroller.clear();
                    },
                    child: const Text('Clear Details'),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  adddetailsbuttonclicked() async {
    var _name = _namecontroller.text.trim();
    var _age = _agecontroller.text.trim();
    var _address = _addresscontroller.text.trim();
    var _domain = _domaincontroller.text.trim();
    var image = _image?.path;

    if (formkey.currentState!.validate()) {
      if (_name.isNotEmpty && _address.isNotEmpty && _domain.isNotEmpty) {
        await addStudent(StudentModel(
            name: _name,
            age: _age,
            domain: _domain,
            address: _address,
            image: image?.toString() ?? ''));
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> uploadImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }
}
