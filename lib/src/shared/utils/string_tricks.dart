class StringTricks {
  const StringTricks._();

  /// Method that replace [slot] for index from [values]
  static String replaceTextWithValues({
    required String text,
    required List<dynamic> values,
  }) {
    for (int i = 0; i < values.length; i++) {
      final slot = "{$i}";
      text = text.replaceAll(slot, values[i]);
    }
    return text;
  }
}
