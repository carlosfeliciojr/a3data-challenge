class MapTricks {
  const MapTricks._();

  static List<Map<String, dynamic>> castList(List<dynamic> list) {
    return list.map((item) => item as Map<String, dynamic>).toList();
  }
}
