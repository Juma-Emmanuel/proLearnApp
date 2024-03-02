class Note {
  final int noteId;
  final String name;
  final String topic;
  final String subtopic;
  final String content;

  Note(
      {required this.noteId,
      required this.name,
      required this.topic,
      required this.subtopic,
      required this.content});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteId: json['id'] ?? '',
      name: json['name'] ?? '',
      topic: json['topic'] ?? '',
      subtopic: json['subtopic'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
