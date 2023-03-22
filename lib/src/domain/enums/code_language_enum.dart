enum CodeLanguageEnum {
  dart(text: "Dart"),
  unidentified(text: "Não identificado");

  final String text;

  const CodeLanguageEnum({required this.text});

  factory CodeLanguageEnum.fromText({required String text}) {
    return values.firstWhere(
      (code) => code.text == text,
      orElse: () => CodeLanguageEnum.unidentified,
    );
  }
}
