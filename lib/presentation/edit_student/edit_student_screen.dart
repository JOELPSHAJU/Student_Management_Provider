import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagementprovider/core/constants.dart';
import 'package:studentmanagementprovider/database/database_helper.dart';
import 'package:studentmanagementprovider/model/data_model.dart';
import 'package:studentmanagementprovider/provider/edit_student_provider/edit_student_provider.dart';
import 'package:studentmanagementprovider/widgets/savebutton.dart';

class EditStudentScreen extends StatelessWidget {
  final Student student;
  EditStudentScreen({super.key, required this.student});

  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editStudentProvider = Provider.of<EditStudentProvider>(context);

    _nameController.text = student.name;
    _schoolNameController.text = student.schoolname;
    _fatherNameController.text = student.fathername;
    _ageController.text = student.age.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        toolbarHeight: 40,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primarycolor, secondarycolor])),
        ),
        title: const Text(
          'Edit Student',
          style: appbarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              h2,
              GestureDetector(
                onTap: () async {
                  XFile? img = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  editStudentProvider.setImage(img);
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: editStudentProvider.profilePicturePath !=
                          null
                      ? FileImage(File(editStudentProvider.profilePicturePath!))
                      : FileImage(File(student.profilePicturePath)),
                ),
              ),
              h2,
              TextFormField(
                controller: _nameController,
                decoration: decoration(label: 'Student Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Student Name';
                  } else {
                    return null;
                  }
                },
              ),
              h2,
              TextFormField(
                controller: _schoolNameController,
                decoration: decoration(label: 'School Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter The school Name';
                  } else {
                    return null;
                  }
                },
              ),
              h2,
              TextFormField(
                controller: _fatherNameController,
                decoration: decoration(label: 'Father Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Father Name';
                  } else {
                    return null;
                  }
                },
              ),
              h2,
              TextFormField(
                controller: _ageController,
                decoration: decoration(label: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Age';
                  } else {
                    return null;
                  }
                },
              ),
              h4,
              Savebutton(onTap: () {
                if (_formkey.currentState!.validate()) {
                  final name = _nameController.text;
                  final schoolname = _schoolNameController.text;
                  final fathername = _fatherNameController.text;
                  final age = int.parse(_ageController.text);

                  final updatedStudent = Student(
                    id: student.id,
                    name: name,
                    schoolname: schoolname,
                    fathername: fathername,
                    age: age,
                    profilePicturePath:
                        editStudentProvider.profilePicturePath ??
                            student.profilePicturePath,
                  );

                  DatabaseHelper datahelp = DatabaseHelper();
                  datahelp.updateStudent(updatedStudent).then((id) {
                    if (id > 0) {
                      AnimatedSnackBar.rectangle(
                              'Updated', 'Details Updated Sucessfully',
                              type: AnimatedSnackBarType.info,
                              duration: const Duration(seconds: 3))
                          .show(context);
                      Navigator.pop(context);
                    } else {
                      AnimatedSnackBar.rectangle(
                              'Failed', 'Failed to update the Details',
                              type: AnimatedSnackBarType.error,
                              duration: const Duration(seconds: 3))
                          .show(context);
                    }
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
