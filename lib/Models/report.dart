class Report {
  final int completedCourses;
  final int inProgressCourses;
  final String firstName;
  final String lastName;
  final String dateJoined;

  Report({
    required this.completedCourses,
    required this.inProgressCourses,
    required this.firstName,
    required this.lastName,
    required this.dateJoined,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      completedCourses: json['completed_courses'] ?? '',
      inProgressCourses: json['in_progress_courses'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dateJoined: json['date_joined'] ?? '',
    );
  }
}
