import 'package:flutter/material.dart';
import 'package:online_course/Controllers/GetReport.dart';
import 'package:online_course/Models/report.dart';

import 'package:online_course/widgets/report_item.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Report? report;
  GetReport getReport = GetReport();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Report fetchedUser = await getReport.fetchReport();
      setState(() {
        report = fetchedUser;
      });
    } catch (e) {
      throw Exception('Error during fetch request: $e');
    }
  }

  Future<void> _refreshData() async {
    Report fetchedUser = await getReport.fetchReport();
    setState(() {
      report = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Learning Progress Report',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: report != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ReportItem(
                            reportTitle: 'First Name:',
                            reportContent: report!.firstName,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ReportItem(
                            reportTitle: 'Last Name:',
                            reportContent: report!.lastName,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ReportItem(
                            reportTitle: 'Date Joined:',
                            reportContent: report!.dateJoined,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ReportItem(
                            reportTitle: 'Courses in Progress:',
                            reportContent: report!.inProgressCourses.toString(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ReportItem(
                            reportTitle: 'Completed Courses:',
                            reportContent: report!.inProgressCourses.toString(),
                          ),
                        )
                      ],
                    )
                  : CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}

