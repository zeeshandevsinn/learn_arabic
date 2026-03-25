import '../models/lesson_model.dart';
import '../data/app_data.dart';

class LessonController {
  List<Lesson> _lessons = [];

  LessonController() {
    _lessons = AppData.lessons;
  }

  List<Lesson> get lessons => _lessons;

  Lesson? getLessonById(String id) {
    try {
      return _lessons.firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Lesson> searchLessons(String query) {
    if (query.isEmpty) {
      return _lessons;
    }
    return _lessons
        .where((lesson) =>
            lesson.title.toLowerCase().contains(query.toLowerCase()) ||
            lesson.topic.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}