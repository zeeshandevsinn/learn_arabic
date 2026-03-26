import '../models/lesson_model.dart';
import '../data/app_data.dart';

class LessonController {
  static final LessonController _instance = LessonController._internal();
  factory LessonController() => _instance;
  LessonController._internal();

  List<Lesson> _lessons = [];
  bool _isLoading = true;

  Future<void> initialize() async {
    _isLoading = true;
    _lessons = await AppData.getLessons();
    _isLoading = false;
  }

  List<Lesson> get lessons => _lessons;

  bool get isLoading => _isLoading;

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

  Future<void> refreshLessons() async {
    await initialize();
  }
}
