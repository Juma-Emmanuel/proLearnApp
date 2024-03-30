import 'package:flutter/material.dart';
import 'package:online_course/Controllers/AddToCollection.dart';
import 'package:online_course/Controllers/GetCollectionCourses.dart';

import 'package:online_course/Controllers/GetLessons.dart';
import 'package:online_course/Models/Course.dart';
import 'package:online_course/Models/Lesson.dart';

import 'package:online_course/screens/notesView.dart';

import 'package:online_course/widgets/objective_item.dart';

class CoursesOutline extends StatefulWidget {
  final int courseId;
  final String courseName;

  const CoursesOutline(
      {super.key, required this.courseId, required this.courseName});
  @override
  State<CoursesOutline> createState() => _CoursesOutlineState();
}

class _CoursesOutlineState extends State<CoursesOutline> {
  GetLessons getLessons = GetLessons();
  List<Lesson> lessons = [];
  final AddToCollection request = AddToCollection();
  final GetCollectionCourses getCollectionCourses = GetCollectionCourses();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Lesson> fetchedLessons =
          await getLessons.fetchLessons(widget.courseId);
      await getCollectionCourses.fetchCourses();
      setState(() {
        lessons = fetchedLessons;
      });
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Course outline',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    runSpacing: 5.1,
                    children: List.generate(
                      lessons.length,
                      (index) => InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ObjectiveItem(
                            data: lessons[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            request.addToCollectionRequest(widget.courseId).then((response) {
              switch (response) {
                case 'success':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.only(bottom: 410),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      content: Text(
                        'Enrollment was Successful',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  fetchData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesView(
                        courseId: widget.courseId,
                        courseName: widget.courseName,
                      ),
                    ),
                  );
                  break;
                case 'bad_request':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.only(bottom: 410),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color.fromARGB(255, 189, 56, 38),
                      content:
                          Text('You have already enrolled on this course.'),
                    ),
                  );
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.only(bottom: 410),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color.fromARGB(255, 189, 56, 38),
                      content: Text('Enrollment failed. Please try again.'),
                    ),
                  );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 49, 218, 55),
          ),
          child: Text(
            'Enroll',
            style: TextStyle(fontSize: 19, color: Colors.white),
          ),
        ),
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
