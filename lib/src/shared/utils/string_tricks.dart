class StringTricks {
  const StringTricks._();

  /// Method that replace [slot] for index from [values]
  static String replaceTextWithValues({
    required String text,
    required List<dynamic> values,
  }) {
    for (int index = 0; index < values.length; index++) {
      final slot = "{$index}";
      text = text.replaceAll(slot, values[index].toString());
    }
    return text;
  }
}
