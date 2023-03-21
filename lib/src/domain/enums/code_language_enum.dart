enum CodeLanguageEnum {
  dart(text: "dart");

  final String text;

  const CodeLanguageEnum({required this.text});

  factory CodeLanguageEnum.fromText({required String text}) {
    return values.firstWhere((code) => code.text == text);
  }
}
