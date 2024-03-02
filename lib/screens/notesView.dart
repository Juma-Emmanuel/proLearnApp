import 'package:flutter/material.dart';
import 'package:online_course/Controllers/GetNotes.dart';
import 'package:online_course/Models/Note.dart';

class NotesView extends StatefulWidget {
  final int courseId;
  final String courseName;
  const NotesView(
      {super.key, required this.courseId, required this.courseName});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  GetNotes getNotes = GetNotes();
  List<Note> notes = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Note> fetchedNotes = await getNotes.fetchNotes(widget.courseId);
      print(fetchedNotes);
      setState(() {
        notes = fetchedNotes;
      });
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.courseName,
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ExpansionTile(
                  title: Text(
                    notes[index].topic,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 23, 109, 12),
                      fontSize: 21.0,
                    ),
                  ),

                  children: [
                    Text(
                      notes[index].subtopic,
                      style: TextStyle(
                          color: Color.fromARGB(185, 197, 50, 5),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(notes[index].content,
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                    ),
                  ],
                  // trailing: Column(
                  //   children: [
                  //     Text(notes[index].subtopic),
                  //     Text(notes[index].content),
                  //   ],
                  // ),
                  // children: course.topics[index].subtopics.map((subtopic) {
                  //   return Column(
                  //     children: [
                  //       Text(notes[index].subtopic),
                  //       Text(notes[index].content),
                  //     ],
                  //   );
                  // }).toList(),
                );
              },
              childCount: notes.length,
            ),
          ),
        ],
      ),
    );
  }
}
