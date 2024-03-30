class Lesson {
  final int lessonId;
  final String lessonName;

  Lesson({
    required this.lessonId,
    required this.lessonName,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['id'] ?? '',
      lessonName: json['name'] ?? '',
    );
  }
}
