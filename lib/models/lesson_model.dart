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
}

class ConversationLine {
  final String arabic;
  final String english;

  ConversationLine({
    required this.arabic,
    required this.english,
  });
}