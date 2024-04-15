import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagementprovider/core/constants.dart';
import 'package:studentmanagementprovider/database/database_helper.dart';
import 'package:studentmanagementprovider/model/data_model.dart';
import 'package:studentmanagementprovider/provider/add_student_provider/add_student_provider.dart';
import 'package:studentmanagementprovider/widgets/savebutton.dart';

class AddStudentScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 45,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primarycolor, secondarycolor])),
        ),
        backgroundColor: primarycolor,
        title: const Text(
          'Add Students',
          style: appbarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: Consumer<AddStudentProvider>(
            builder: (context, addStudentProvider, _) {
              return ListView(
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      // ignore: use_build_context_synchronously
                      Provider.of<AddStudentProvider>(context, listen: false)
                          .setImage(img);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: const LinearGradient(
                                  colors: [primarycolor, secondarycolor])),
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                addStudentProvider.profilePicturePath != null
                                    ? FileImage(File(
                                        addStudentProvider.profilePicturePath!))
                                    : null,
                            child: addStudentProvider.profilePicturePath == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    size: 35,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ],
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
                    decoration: decoration(label: "Age"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Age';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  h4,
                  Savebutton(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        final student = Student(
                          id: 0,
                          name: _nameController.text,
                          schoolname: _schoolNameController.text,
                          fathername: _fatherNameController.text,
                          age: int.parse(_ageController.text),
                          profilePicturePath:
                              addStudentProvider.profilePicturePath ?? '',
                        );
                        databaseHelper.insertStudent(student).then((id) {
                          if (id > 0) {
                            AnimatedSnackBar.rectangle(
                              'Success',
                              'Student Added Sucessfully',
                              type: AnimatedSnackBarType.success,
                              brightness: Brightness.dark,
                            ).show(
                              context,
                            );
                            Navigator.pop(context);
                          } else {
                            AnimatedSnackBar.rectangle(
                              'Failes',
                              'Failed to add Student',
                              type: AnimatedSnackBarType.success,
                              brightness: Brightness.dark,
                            ).show(
                              context,
                            );
                          }
                        });
                        Provider.of<AddStudentProvider>(context, listen: false)
                            .clearImage();
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
