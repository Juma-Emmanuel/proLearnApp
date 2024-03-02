class TCourse {
  final int courseId;
  final String name;

  TCourse({
    required this.courseId,
    required this.name,
  });

  factory TCourse.fromJson(Map<String, dynamic> json) {
    return TCourse(
      courseId: json['courseId'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
