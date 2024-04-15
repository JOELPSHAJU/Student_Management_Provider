import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagementprovider/core/constants.dart';
import 'package:studentmanagementprovider/model/data_model.dart';
import 'package:studentmanagementprovider/presentation/edit_student/edit_student_screen.dart';
import 'package:studentmanagementprovider/provider/student_detail_provider/student_detail_provider.dart';
import 'package:studentmanagementprovider/widgets/delete_dialouge.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;
  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: appbarText,
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primarycolor, secondarycolor])),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStudentScreen(student: student),
                ),
              ).then((_) => Navigator.pop(context));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          h3,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(student.profilePicturePath)),
                ),
              ),
            ),
          ),
          h3,
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  'Personal Information',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          h2,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: PersonalInfoTile(
                size: size,
                label: 'Name',
                info: student.name,
              ),
            ),
          ),
          h1,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: PersonalInfoTile(
                    size: size,
                    label: 'School Name',
                    info: student.schoolname)),
          ),
          h1,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: PersonalInfoTile(
                    size: size,
                    label: 'Fathers Name',
                    info: student.fathername)),
          ),
          h1,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: PersonalInfoTile(
                    size: size, label: 'Age', info: student.age.toString())),
          )
        ],
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        onCancel: () {
          Navigator.pop(context);
        },
        onDelete: () {
          Provider.of<StudentDetailProvider>(context, listen: false)
              .deleteStudent(student.id);

          AnimatedSnackBar.rectangle('Deleted', 'Student Deleted Sucessfully',
                  type: AnimatedSnackBarType.error,
                  duration: const Duration(seconds: 3),
                  brightness: Brightness.light)
              .show(context);
          void popUntilHomeScreen(BuildContext context) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }

          popUntilHomeScreen(context);
        },
      ),
    );
  }
}

class PersonalInfoTile extends StatelessWidget {
  const PersonalInfoTile(
      {super.key, required this.label, required this.info, required this.size});

  final String label;
  final Size size;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * .37,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 173, 173, 173)),
            ),
          ),
          const Text(
            ' :  ',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 173, 173, 173)),
          ),
          Expanded(
            child: Text(
              info,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
