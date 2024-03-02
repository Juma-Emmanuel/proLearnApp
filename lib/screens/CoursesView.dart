import 'package:flutter/material.dart';
import 'package:online_course/Models/Course.dart';
import 'package:online_course/widgets/CourseItem.dart';

import '../Controllers/GetCourseProducts.dart';

class CoursesView extends StatefulWidget {
  final String title;

  const CoursesView({super.key, required this.title});
  @override
  State<CoursesView> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesView> {
  GetCourseProducts getCourses = GetCourseProducts();
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Course> fetchedCourses = await getCourses.fetchCourses();

      setState(() {
        courses = fetchedCourses;
      });
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CourseItem(
                data: courses[index],
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         //  CoursePage(course: courses[index])
              //         NotesView(
              //       courseId: courses[index].courseId,
              //       courseName: courses[index].name,
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
