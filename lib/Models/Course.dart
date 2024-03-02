class Course {
  final int courseId;
  final String name;
  final String image;
  final String price;
  final String duration;
  final String session;
  final String review;
  final String is_favorited;
  final String description;

  Course({
    required this.courseId,
    required this.name,
    required this.image,
    required this.price,
    required this.duration,
    required this.session,
    required this.review,
    required this.is_favorited,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? '',
      duration: json['duration'] ?? '',
      session: json['session'] ?? '',
      review: json['review'] ?? '',
      is_favorited: json['is_favorited'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
