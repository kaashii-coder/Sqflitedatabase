import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_weekfive/function/db_function.dart';
import 'package:main_weekfive/model/studentmodel.dart';
import 'package:image_picker/image_picker.dart';

class EditStudent_Screen extends StatefulWidget {
  final StudentModel editstudentModel;
  EditStudent_Screen({
    super.key,
    required this.editstudentModel,
  });

  @override
  State<EditStudent_Screen> createState() => _EditStudent_ScreenState();
}

class _EditStudent_ScreenState extends State<EditStudent_Screen> {
  late StudentModel studentModel;
  late TextEditingController _namecontroller;

  late TextEditingController _agecontroller;

  late TextEditingController _addresscontroller;

  late TextEditingController _domaincontroller;
  late XFile _selectedimage;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    print(widget.editstudentModel.id);
    // TODO: implement initState
    super.initState();
    _namecontroller = TextEditingController(text: widget.editstudentModel.name);
    _agecontroller = TextEditingController(text: widget.editstudentModel.age);
    _addresscontroller =
        TextEditingController(text: widget.editstudentModel.address);
    _domaincontroller =
        TextEditingController(text: widget.editstudentModel.domain);
    studentModel = widget.editstudentModel;
    _image = XFile(widget.editstudentModel.image);
  }

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
                    _image != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(_image!.path)))
                        : const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('Asset/th.jpeg'),
                          ),
                    ElevatedButton(
                      onPressed: uploadImage,
                      child: Text('pick image'),
                    ),
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
                      editdetailsbuttonclicked();
                    },
                    child: const Text('update Details'),
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

  editdetailsbuttonclicked() async {
    var _name = _namecontroller.text.trim();
    //i ignonred this code bcoz age field can add only numbers.
    var _age = _agecontroller.text.trim();
    var _address = _addresscontroller.text.trim();
    var _domain = _domaincontroller.text.trim();
    var image = _image?.path;

    if (formkey.currentState!.validate()) {
      if (_name.isNotEmpty && _address.isNotEmpty && _domain.isNotEmpty) {
        final _changestudentdb = StudentModel(
          name: _name,
          age: _age,
          domain: _domain,
          address: _address,
          image: image.toString(),
        );
        await updateStudent(_changestudentdb, studentModel.id);
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> uploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }
}
