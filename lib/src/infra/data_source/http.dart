abstract class Http {
  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> post({
    required String url,
    required dynamic data,
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> put({
    required String url,
    required dynamic data,
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> delete({
    required String url,
    Map<String, String>? headers,
  });
}
