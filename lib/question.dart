class Question {
  String text;
  bool ans;

  Question({String text, bool ans}) {
    this.ans = ans;
    this.text = text;
  }
}

List<Question> questions = [
  Question(
      text: 'You can lead a cow down stairs but not up stairs.', ans: false),
  Question(
      text: 'Approximately one quarter of human bones are in the feet.',
      ans: true),
  Question(text: 'A slug\'s blood is green.', ans: true),
];
