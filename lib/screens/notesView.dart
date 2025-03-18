import 'package:flutter/material.dart';
import 'package:online_course/Controllers/AddToCompleted.dart';
import 'package:online_course/Controllers/GetNotes.dart';
import 'package:online_course/Models/Note.dart';
import 'package:online_course/screens/learnView.dart';

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
  final AddToCompleted request = AddToCompleted();
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

  Future<void> fetchData2() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.courseName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchData2(),
        child: CustomScrollView(
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
                  );
                },
                childCount: notes.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            request.addToCompletedRequest(widget.courseId).then((response) {
              switch (response) {
                case 'success':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.only(bottom: 410),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      content: Text(
                        'Congratulations! Course completed succesfully',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  fetchData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LearnView(),
                    ),
                  );
                  break;
                case 'bad_request':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.only(bottom: 410),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color.fromARGB(255, 189, 56, 38),
                      content: Text('You have already completed the  course.'),
                    ),
                  );
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.only(bottom: 410),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color.fromARGB(255, 189, 56, 38),
                      content: Text('Check Network and try again.'),
                    ),
                  );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 49, 218, 55),
          ),
          child: Text(
            'Complete Course',
            style: TextStyle(fontSize: 19, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
