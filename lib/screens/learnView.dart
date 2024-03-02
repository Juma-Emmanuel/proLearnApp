import 'package:flutter/material.dart';
import 'package:online_course/Controllers/GetCourses.dart';
import 'package:online_course/Models/Course.dart';
import 'package:online_course/screens/notesView.dart';
import 'package:online_course/widgets/enrolledCourse.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  GetCourses getCourses = GetCourses();
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

  // final List<Course> courses = [
  //   Course(
  //     name: 'Flutter',
  //     description: 'Learn how to build beautiful and fast apps with Flutter',
  //     image: 'flutter.png',
  //     topics: [
  //       Topic(
  //         name: 'Introduction',
  //         subtopics: [
  //           Subtopic(
  //             name: 'What is Flutter?',
  //             notes:
  //                 'Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
  //           ),
  //           Subtopic(
  //             name: 'Why Flutter?',
  //             notes:
  //                 'Flutter offers fast development, expressive and flexible UI, native performance, and a large and growing community.',
  //           ),
  //         ],
  //       ),
  //       Topic(
  //         name: 'Widgets',
  //         subtopics: [
  //           Subtopic(
  //             name: 'What are widgets?',
  //             notes:
  //                 'Widgets are the basic building blocks of a Flutter app\'s user interface. Each widget is an immutable declaration of part of the user interface.',
  //           ),
  //           Subtopic(
  //             name: 'How to use widgets?',
  //             notes:
  //                 'Widgets are organized into a tree of parent and child widgets. The framework builds the widget tree to render the app on the screen.',
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
  //   Course(
  //     name: 'Dart',
  //     description:
  //         'Learn how to program with Dart, a modern and concise language',
  //     image: 'dart.png',
  //     topics: [
  //       Topic(
  //         name: 'Basics',
  //         subtopics: [
  //           Subtopic(
  //             name: 'Variables',
  //             notes:
  //                 'Variables store references to values. In Dart, variables can be declared using var, final, or const keywords.',
  //           ),
  //           Subtopic(
  //             name: 'Types',
  //             notes:
  //                 'Dart is an optionally typed language, which means that you can use types or omit them. Types help to document and catch errors at compile time.',
  //           ),
  //         ],
  //       ),
  //       Topic(
  //         name: 'Functions',
  //         subtopics: [
  //           Subtopic(
  //             name: 'What are functions?',
  //             notes:
  //                 'Functions are a set of statements that perform a specific task. Functions can have parameters and return values.',
  //           ),
  //           Subtopic(
  //             name: 'How to use functions?',
  //             notes:
  //                 'Functions can be invoked by using parentheses and passing arguments. Functions can also be assigned to variables or passed as arguments to other functions.',
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Learning'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EnrolledCourse(
                data: courses[index],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      //  CoursePage(course: courses[index])
                      NotesView(
                    courseId: courses[index].courseId,
                    courseName: courses[index].name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CoursePage extends StatelessWidget {
  final Course course;

  CoursePage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
    );
  }
}
