import '../models/word_model.dart';
import '../data/app_data.dart';

class DictionaryController {
  static final DictionaryController _instance =
      DictionaryController._internal();
  factory DictionaryController() => _instance;
  DictionaryController._internal();

  List<Word> _allWords = [];
  List<Word> _searchResults = [];
  bool _isLoading = true;

  Future<void> initialize() async {
    _isLoading = true;
    _allWords = await AppData.getDictionaryWords();
    _searchResults = List.from(_allWords);
    _isLoading = false;
  }

  List<Word> get searchResults => _searchResults;

  bool get isLoading => _isLoading;

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

  Future<void> refreshDictionary() async {
    await initialize();
    _searchResults = List.from(_allWords);
  }
}
