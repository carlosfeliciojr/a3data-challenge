abstract class Http {
  Future<dynamic> get({
    required String url,
    Map<String, String>? headers,
  });

  Future<dynamic> post({
    required String url,
    required dynamic data,
    Map<String, String>? headers,
  });

  Future<dynamic> put({
    required String url,
    required dynamic data,
    Map<String, String>? headers,
  });

  Future<dynamic> delete({
    required String url,
    Map<String, String>? headers,
  });
}
