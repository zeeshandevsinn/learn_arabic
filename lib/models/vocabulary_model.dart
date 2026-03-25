class VocabularyItem {
  final String arabicWord;
  final String englishMeaning;
  final String exampleSentence;

  VocabularyItem({
    required this.arabicWord,
    required this.englishMeaning,
    required this.exampleSentence,
  });

  factory VocabularyItem.fromJson(Map<String, dynamic> json) {
    return VocabularyItem(
      arabicWord: json['arabicWord'],
      englishMeaning: json['englishMeaning'],
      exampleSentence: json['exampleSentence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arabicWord': arabicWord,
      'englishMeaning': englishMeaning,
      'exampleSentence': exampleSentence,
    };
  }
}