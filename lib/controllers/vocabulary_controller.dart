import '../models/vocabulary_model.dart';
import '../data/app_data.dart';

class VocabularyController {
  static final VocabularyController _instance =
      VocabularyController._internal();
  factory VocabularyController() => _instance;
  VocabularyController._internal();

  List<VocabularyItem> _vocabularyItems = [];
  bool _isLoading = true;

  Future<void> initialize() async {
    _isLoading = true;
    _vocabularyItems = await AppData.getDailyVocabulary();
    _isLoading = false;
  }

  List<VocabularyItem> get vocabularyItems => _vocabularyItems;

  bool get isLoading => _isLoading;

  List<VocabularyItem> getTodaysVocabulary() {
    return _vocabularyItems;
  }

  VocabularyItem? getVocabularyItem(String arabicWord) {
    try {
      return _vocabularyItems
          .firstWhere((item) => item.arabicWord == arabicWord);
    } catch (e) {
      return null;
    }
  }

  Future<void> refreshVocabulary() async {
    await initialize();
  }
}
