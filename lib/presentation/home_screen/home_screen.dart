import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagementprovider/core/constants.dart';
import 'package:studentmanagementprovider/core/decoration_homepage.dart';
import 'package:studentmanagementprovider/presentation/add_student/add_student_screen.dart';
import 'package:studentmanagementprovider/presentation/student_details/student_details_screenl.dart';
import 'package:studentmanagementprovider/provider/student_list_provider/student_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final homeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 130,
              width: size.width,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [primarycolor, secondarycolor])),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(' Student Management', style: appbarText),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600),
                        onChanged: (query) {
                          homeProvider.filterStudents(query);
                        },
                        decoration: DecorationHomeSceen()),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.transparent,
            ),
            homeProvider.filteredStudents.isEmpty
                ? Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/no_student_found.png',
                        width: size.width * .75,
                      ),
                      h2,
                      const Text(
                        'No Student Found!',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      )
                    ],
                  ))
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      itemCount: homeProvider.filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = homeProvider.filteredStudents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StudentDetailScreen(student: student),
                              ),
                            ).then(
                                (value) => homeProvider.refreshStudentList());
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage: FileImage(
                                      File(student.profilePicturePath),
                                    ),
                                  ),
                                  h1,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      child: Text(
                                        '${student.name} (${student.age})',
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      child: Text(
                                        student.schoolname,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddStudentScreen()))
                .then((value) => homeProvider.refreshStudentList());
          },
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                      colors: [primarycolor, secondarycolor])),
              child: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
