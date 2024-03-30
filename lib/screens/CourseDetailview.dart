import 'package:flutter/material.dart';
import 'package:online_course/screens/CourseOutline.dart';
import 'package:online_course/widgets/custom_image.dart';

class CourseDetailView extends StatefulWidget {
  final int courseId;
  final String name;
  final String image;
  final String description;
  final String session;
  final String duration;
  final String price;
  final String review;

  const CourseDetailView(
      {super.key,
      required this.courseId,
      required this.name,
      required this.image,
      required this.description,
      required this.session,
      required this.duration,
      required this.price,
      required this.review});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: TextStyle(
                    color: Color(0XFF3B61C0),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImage(
                widget.image,
                width: double.infinity,
                height: 190,
                radius: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.description,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      size: 29,
                      Icons.monetization_on_outlined,
                      color: Colors.lime,
                    ),
                  ),
                  Text(
                    widget.price,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      size: 29,
                      Icons.watch_later_outlined,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    widget.duration,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      size: 29,
                      Icons.school_outlined,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    widget.session,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      size: 29,
                      Icons.star_border_outlined,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    widget.review,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XffEA481A),
                    ),
                    child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoursesOutline(
                            courseId: widget.courseId,
                            courseName: widget.name,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 49, 218, 55),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
