import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/word_model.dart';
import '../models/vocabulary_model.dart';
import '../models/lesson_model.dart';

class DataLoader {
  // Load words from JSON file
  static Future<List<Word>> loadWords() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/word.json');
      List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => Word.fromJson(item)).toList();
    } catch (e) {
      print('Error loading words: $e');
      return [];
    }
  }

  // Load vocabulary from JSON file
  static Future<List<VocabularyItem>> loadVocabulary() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data/vocabulary.json');
      List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => VocabularyItem.fromJson(item)).toList();
    } catch (e) {
      print('Error loading vocabulary: $e');
      return [];
    }
  }

  // Load lessons from JSON file
  static Future<List<Lesson>> loadLessons() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data/conversations.json');
      List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => Lesson.fromJson(item)).toList();
    } catch (e) {
      print('Error loading lessons: $e');
      return [];
    }
  }

  // Load all data at once
  static Future<Map<String, dynamic>> loadAllData() async {
    List<Word> words = await loadWords();
    List<VocabularyItem> vocabulary = await loadVocabulary();
    List<Lesson> lessons = await loadLessons();

    return {
      'words': words,
      'vocabulary': vocabulary,
      'lessons': lessons,
    };
  }
}
