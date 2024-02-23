import 'package:flutter/material.dart';

class CourseView extends StatefulWidget {
  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  List<Course> courses = [
    Course(
      name: 'Course 1',
      topics: [
        Topic(
          name: 'Topic 1',
          subtopics: [
            Subtopic(name: 'Subtopic 1.1', notes: 'Notes for Subtopic 1.1'),
            Subtopic(name: 'Subtopic 1.2', notes: 'Notes for Subtopic 1.2'),
          ],
        ),
        Topic(
          name: 'Topic 2',
          subtopics: [
            Subtopic(name: 'Subtopic 2.1', notes: 'Notes for Subtopic 2.1'),
            Subtopic(name: 'Subtopic 2.2', notes: 'Notes for Subtopic 2.2'),
          ],
        ),
      ],
    ),
    Course(
      name: 'Course 2',
      topics: [
        Topic(
          name: 'Topic 1',
          subtopics: [
            Subtopic(name: 'Subtopic 1.1', notes: 'Notes for Subtopic 1.1'),
            Subtopic(name: 'Subtopic 1.2', notes: 'Notes for Subtopic 1.2'),
          ],
        ),
        Topic(
          name: 'Topic 2',
          subtopics: [
            Subtopic(name: 'Subtopic 2.1', notes: 'Notes for Subtopic 2.1'),
            Subtopic(name: 'Subtopic 2.2', notes: 'Notes for Subtopic 2.2'),
          ],
        ),
      ],
    ),
  ];

  Course? selectedCourse;
  Topic? selectedTopic;
  Subtopic? selectedSubtopic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Courses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: courses.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(courses[index].name),
            //         onTap: () {
            //           setState(() {
            //             selectedCourse = courses[index];
            //             selectedTopic = null;
            //             selectedSubtopic = null;
            //           });
            //         },
            //       );
            //     },
            //   ),
            // ),
            if (selectedCourse != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Topics',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedCourse!.topics.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(selectedCourse!.topics[index].name),
                          children: selectedCourse!.topics[index].subtopics
                              .map(
                                (subtopic) => ListTile(
                                  title: Text(subtopic.name),
                                  onTap: () {
                                    setState(() {
                                      selectedTopic =
                                          selectedCourse!.topics[index];
                                      selectedSubtopic = subtopic;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                  if (selectedTopic != null && selectedSubtopic != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(selectedSubtopic!.notes),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final List<Topic> topics;

  Course({required this.name, required this.topics});
}

class Topic {
  final String name;
  final List<Subtopic> subtopics;

  Topic({required this.name, required this.subtopics});
}

class Subtopic {
  final String name;
  final String notes;

  Subtopic({required this.name, required this.notes});
}
