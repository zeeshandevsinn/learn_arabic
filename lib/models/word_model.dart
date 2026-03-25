class Word {
  final String arabicWord;
  final String englishMeaning;
  final String? exampleSentence;

  Word({
    required this.arabicWord,
    required this.englishMeaning,
    this.exampleSentence,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
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