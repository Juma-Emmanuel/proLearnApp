import 'package:flutter/material.dart';

class ReportItem extends StatefulWidget {
  final String reportTitle;
  final String reportContent;

  const ReportItem(
      {super.key, required this.reportTitle, required this.reportContent});

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.reportTitle,
                style: TextStyle(
                  color: Color(0XFF726666),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                // style: textStyle.bodyMediumGrey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.reportContent,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Divider(
                color: Colors.grey,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
