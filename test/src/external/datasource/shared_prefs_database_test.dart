import 'package:a3data_challenge/src/external/drivers/shared_preferences_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_prefs_database_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  final SharedPreferences mockSharedPreferences = MockSharedPreferences();
  final SharedPreferencesDatabase sharedPrefsDatabase =
      SharedPreferencesDatabase(
    sharedPreferences: mockSharedPreferences,
  );

  group('SharedPrefsDatabase tests', () {
    test('getItem should return null if key is not found', () async {
      when(mockSharedPreferences.getString('s')).thenReturn(null);

      final result = await sharedPrefsDatabase.getItem(key: 'non-existent-key');

      expect(result, null);
    });

    test('setItem should call SharedPreferences.setString', () async {
      final testData = {'key': 'value'};

      await sharedPrefsDatabase.setItem(
        key: 'test-key',
        data: testData,
      );

      verify(mockSharedPreferences.setString(
        'test-key',
        '{"key":"value"}',
      ));
    });

    test('removeItem should call SharedPreferences.remove', () async {
      await sharedPrefsDatabase.removeItem(key: 'test-key');

      verify(mockSharedPreferences.remove('test-key'));
    });

    test('clear should call SharedPreferences.clear', () async {
      await sharedPrefsDatabase.clear();

      verify(mockSharedPreferences.clear());
    });
  });
}
