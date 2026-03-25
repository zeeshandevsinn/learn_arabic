import '../models/word_model.dart';
import '../data/app_data.dart';

class DictionaryController {
  List<Word> _allWords = [];
  List<Word> _searchResults = [];

  DictionaryController() {
    _allWords = AppData.dictionaryWords;
    _searchResults = List.from(_allWords);
  }

  List<Word> get searchResults => _searchResults;

  void searchWords(String query) {
    if (query.isEmpty) {
      _searchResults = List.from(_allWords);
    } else {
      _searchResults = _allWords
          .where((word) =>
              word.arabicWord.contains(query) ||
              word.englishMeaning.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Word? getWordByArabic(String arabicWord) {
    try {
      return _allWords.firstWhere((word) => word.arabicWord == arabicWord);
    } catch (e) {
      return null;
    }
  }
}