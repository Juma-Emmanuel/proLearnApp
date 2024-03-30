import 'package:flutter/material.dart';
import 'package:online_course/Controllers/GetCategoryCourse.dart';
import 'package:online_course/Models/Course.dart';
import 'package:online_course/screens/CourseDetailview.dart';
import 'package:online_course/widgets/CourseItem.dart';

class CategoryCourseView extends StatefulWidget {
  final String title;

  const CategoryCourseView({super.key, required this.title});
  @override
  State<CategoryCourseView> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CategoryCourseView> {
  GetCategoryCourses getCourses = GetCategoryCourses();
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Course> fetchedCourses = await getCourses.fetchCourses(widget.title);

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CourseItem(
              data: courses[index],
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailView(
                      courseId: courses[index].courseId,
                      name: courses[index].name,
                      image: courses[index].image,
                      description: courses[index].description,
                      price: courses[index].price,
                      duration: courses[index].duration,
                      session: courses[index].session,
                      review: courses[index].review,
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
