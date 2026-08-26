class QuestionCount {
  static int getCount(String text) {
    final wordCount = _countWords(text);

    if (wordCount < 150) {
      return 2;
    }

    if (wordCount < 400) {
      return 3;
    }

    if (wordCount < 700) {
      return 4;
    }

    if (wordCount < 1000) {
      return 5;
    }

    if (wordCount < 1500) {
      return 6;
    }

    return 7;
  }

  static int _countWords(String text) {
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
  }
}