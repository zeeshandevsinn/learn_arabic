class Lesson {
  final String id;
  final String title;
  final String topic;
  final List<ConversationLine> conversations;

  Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.conversations,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var conversationsJson = json['conversations'] as List;
    List<ConversationLine> conversationsList = conversationsJson
        .map((line) => ConversationLine(
              arabic: line['arabic'],
              english: line['english'],
            ))
        .toList();

    return Lesson(
      id: json['id'],
      title: json['title'],
      topic: json['topic'],
      conversations: conversationsList,
    );
  }
}

class ConversationLine {
  final String arabic;
  final String english;

  ConversationLine({
    required this.arabic,
    required this.english,
  });
}
