import 'package:flutter/material.dart';
import 'package:online_course/Controllers/GetCollectionCourses.dart';
import 'package:online_course/Controllers/GetCompletedCourses.dart';

import 'package:online_course/Models/Course.dart';

class MyLearning extends StatefulWidget {
  @override
  State<MyLearning> createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> {
  GetCollectionCourses getCourses = GetCollectionCourses();
  GetCompletedCourses getCompletedCourses = GetCompletedCourses();

  List<Course> collectioncourses = [];
  List<Course> completedcourses = [];

  bool isFirstWidgetVisible = true;
  bool isSecondWidgetVisible = false;

  void toggleWidgets() {
    setState(() {
      isFirstWidgetVisible = !isFirstWidgetVisible;
    });
  }

  void toggleSecondWidget() {
    setState(() {
      // isSecondWidgetVisible = !isSecondWidgetVisible;
      isFirstWidgetVisible = !isFirstWidgetVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Learning'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: isFirstWidgetVisible ? null : toggleWidgets,
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Toggle First Widget',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: isFirstWidgetVisible ? toggleWidgets : null,
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Toggle Second Widget',
                        style: TextStyle(color: Colors.white),
                      ),
                      if (!isFirstWidgetVisible)
                        Container(
                          color: Colors.grey,
                          height: 5.0,
                          // child: Center(child: Text('First Widget')),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isFirstWidgetVisible)
                    Container(
                      color: Colors.green,
                      height: 200.0,
                      child: Center(child: Text('First Widget')),
                    ),
                  if (!isFirstWidgetVisible)
                    Container(
                      color: Colors.orange,
                      height: 200.0,
                      child: Center(child: Text('Second Widget')),
                    ),
                ],
              ),
            ),
          ),
        ],
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
