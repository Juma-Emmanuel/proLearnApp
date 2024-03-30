import 'package:flutter/material.dart';

import 'package:online_course/Controllers/GetCollectionCourses.dart';
import 'package:online_course/Controllers/GetCompletedCourses.dart';

import 'package:online_course/Models/Course.dart';
import 'package:online_course/screens/notesView.dart';
import 'package:online_course/widgets/completed_course.dart';
import 'package:online_course/widgets/enrolledCourse.dart';

class LearnView extends StatefulWidget {
  @override
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Course> fetchedCourses = await getCourses.fetchCourses();
      List<Course> fetchedCompletedCourses =
          await getCompletedCourses.fetchCourses();

      setState(() {
        collectioncourses = fetchedCourses;
        completedcourses = fetchedCompletedCourses;
      });
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> _refreshData() async {
    List<Course> fetchedCourses = await getCourses.fetchCourses();
    List<Course> fetchedCompletedCourses =
        await getCompletedCourses.fetchCourses();
    setState(() {
      collectioncourses = fetchedCourses;
      completedcourses = fetchedCompletedCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'My Learning',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () => _refreshData(),
          child: CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: isFirstWidgetVisible ? null : toggleWidgets,
                          child: Container(
                            color: Colors.blue,
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.edit_document,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Courses in-progress',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: isFirstWidgetVisible ? toggleWidgets : null,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.school,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Completed courses',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      if (isFirstWidgetVisible)
                        Wrap(
                          runSpacing: 5.1,
                          children: List.generate(
                            collectioncourses.length,
                            (index) => InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: EnrolledCourse(
                                  data: collectioncourses[index],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotesView(
                                      courseId:
                                          collectioncourses[index].courseId,
                                      courseName: collectioncourses[index].name,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (!isFirstWidgetVisible)
                        Wrap(
                          runSpacing: 5.1,
                          children: List.generate(
                            completedcourses.length,
                            (index) => InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CompletedCourse(
                                  data: completedcourses[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ]) //customscrollvie
          ),
    );
  }
}
