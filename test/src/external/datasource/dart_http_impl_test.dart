import 'dart:convert';
import 'package:a3data_challenge/src/external/datasource/dart_http_impl.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'dart_http_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Client>(
    as: #MockHttpClient,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  final MockHttpClient mockHttpClient = MockHttpClient();
  final DartHttp dartHttp = DartHttp(http: mockHttpClient);
  const url = 'http://example.com';
  final headers = {'Content-Type': 'application/json'};
  final expectedAnswer = Response('{"message": "Success"}', 200);

  group('DartHttp get tests', () {
    test('should perform a GET request with correct URL and headers', () async {
      when(
        mockHttpClient.get(any, headers: anyNamed("headers")),
      ).thenAnswer((_) async => expectedAnswer);

      final response = await dartHttp.get(url: url, headers: headers);

      expect(response, isA<Map<String, dynamic>>());

      verify(mockHttpClient.get(
        Uri.parse(url),
        headers: headers,
      )).called(1);
    });
  });

  group('DartHttp post tests', () {
    test('should perform a POST request with correct URL, data and headers',
        () async {
      final data = {'message': 'Hello, World!'};

      when(
        mockHttpClient.post(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).thenAnswer(
        (_) async => expectedAnswer,
      );

      final response =
          await dartHttp.post(url: url, data: data, headers: headers);

      expect(response, isA<Map<String, dynamic>>());

      verify(mockHttpClient.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      )).called(1);
    });
  });

  group('DartHttp put tests', () {
    test('should perform a PUT request with correct URL, data and headers',
        () async {
      final data = {'message': 'Hello, World!'};

      when(
        mockHttpClient.put(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).thenAnswer(
        (_) async => expectedAnswer,
      );

      final response =
          await dartHttp.put(url: url, data: data, headers: headers);

      expect(response, isA<Map<String, dynamic>>());

      verify(mockHttpClient.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      )).called(1);
    });
  });

  group('DartHttp delete tests', () {
    test('should perform a DELETE request with correct URL and headers',
        () async {
      when(
        mockHttpClient.delete(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).thenAnswer(
        (_) async => expectedAnswer,
      );

      final response = await dartHttp.delete(url: url, headers: headers);

      expect(response, isA<Map<String, dynamic>>());

      verify(mockHttpClient.delete(
        Uri.parse(url),
        headers: headers,
      )).called(1);
    });
  });
}
