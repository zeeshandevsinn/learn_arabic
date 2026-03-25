import '../models/vocabulary_model.dart';
import '../data/app_data.dart';

class VocabularyController {
  List<VocabularyItem> _vocabularyItems = [];

  VocabularyController() {
    _vocabularyItems = AppData.dailyVocabulary;
  }

  List<VocabularyItem> get vocabularyItems => _vocabularyItems;

  List<VocabularyItem> getTodaysVocabulary() {
    // For now, return all items
    // You can modify this to return random items or specific ones for each day
    return _vocabularyItems;
  }

  VocabularyItem? getVocabularyItem(String arabicWord) {
    try {
      return _vocabularyItems.firstWhere((item) => item.arabicWord == arabicWord);
    } catch (e) {
      return null;
    }
  }
}