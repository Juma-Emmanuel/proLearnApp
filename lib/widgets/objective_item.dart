import 'package:flutter/material.dart';

class ObjectiveItem extends StatefulWidget {
  final data;

  const ObjectiveItem({super.key, this.data});

  @override
  State<ObjectiveItem> createState() => _ObjectiveItemState();
}

class _ObjectiveItemState extends State<ObjectiveItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.grey.shade200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: Colors.white,
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            // spreadRadius: 4,
            // blurRadius: 4,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Lesson " + widget.data.lessonId.toString() + ":",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  widget.data.lessonName,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Divider(
          //     color: Colors.grey,
          //   ),
          // )
        ],
      ),
    );
  }
}
