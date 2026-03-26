import 'package:learn_arabic/controllers/data_loader.dart';

import '../models/word_model.dart';
import '../models/vocabulary_model.dart';
import '../models/lesson_model.dart';

class AppData {
  static List<Word> dictionaryWords = [];
  static List<VocabularyItem> dailyVocabulary = [];
  static List<Lesson> lessons = [];

  static bool isLoading = false;

  // Initialize AppData by loading from JSON files
  static Future<void> init() async {
    if (dictionaryWords.isNotEmpty &&
        dailyVocabulary.isNotEmpty &&
        lessons.isNotEmpty) {
      return; // Already loaded
    }

    isLoading = true;

    try {
      // Load all data
      Map<String, dynamic> data = await DataLoader.loadAllData();

      dictionaryWords = data['words'];
      dailyVocabulary = data['vocabulary'];
      lessons = data['lessons'];

      print('Loaded ${dictionaryWords.length} words');
      print('Loaded ${dailyVocabulary.length} vocabulary items');
      print('Loaded ${lessons.length} lessons');
    } catch (e) {
      print('Error initializing AppData: $e');
    } finally {
      isLoading = false;
    }
  }

  // Optional: Get cached data or load if not available
  static Future<List<Word>> getDictionaryWords() async {
    if (dictionaryWords.isEmpty) {
      await init();
    }
    return dictionaryWords;
  }

  static Future<List<VocabularyItem>> getDailyVocabulary() async {
    if (dailyVocabulary.isEmpty) {
      await init();
    }
    return dailyVocabulary;
  }

  static Future<List<Lesson>> getLessons() async {
    if (lessons.isEmpty) {
      await init();
    }
    return lessons;
  }

  // Get a specific lesson by ID
  static Lesson? getLessonById(String id) {
    try {
      return lessons.firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get lessons by topic
  static List<Lesson> getLessonsByTopic(String topic) {
    return lessons.where((lesson) => lesson.topic == topic).toList();
  }

  // Search in words
  static List<Word> searchWords(String query) {
    if (query.isEmpty) return dictionaryWords;

    return dictionaryWords.where((word) {
      return word.arabicWord.contains(query) ||
          word.englishMeaning.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Search in vocabulary
  static List<VocabularyItem> searchVocabulary(String query) {
    if (query.isEmpty) return dailyVocabulary;

    return dailyVocabulary.where((item) {
      return item.arabicWord.contains(query) ||
          item.englishMeaning.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
