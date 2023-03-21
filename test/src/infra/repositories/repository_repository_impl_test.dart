import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/infra/repositories/repository_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:a3data_challenge/src/infra/data_source/database.dart';

import 'repository_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Database>()])
void main() {
  final Database database = MockDatabase();
  final RepositoryRepositoryImpl repository =
      RepositoryRepositoryImpl(database: database);

  group('RepositoryRepositoryImpl', () {
    group('saveRepositoryInDatabase', () {
      test(
        'Success',
        () async {
          final getItemData = {
            KeysConstants.listFavoritesKey: [
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 151346,
              }
            ]
          };

          when(
            database.getItem(key: KeysConstants.favoritesKey),
          ).thenAnswer(
            (_) async => getItemData,
          );

          final setItemData = {
            KeysConstants.listFavoritesKey: [
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 151346,
              },
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 151346,
              }
            ]
          };

          when(
            database.setItem(
                key: KeysConstants.favoritesKey, data: setItemData),
          ).thenAnswer(
            (_) async {},
          );

          final newFavorite = {
            "id": "31792824",
            "name": "flutter",
            "description":
                "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            "creationDate": "2015-03-06T22:54:58.000",
            "language": "dart",
            "watchers": 151346,
          };

          await repository.saveRepositoryInDatabase(
            newFavorite: newFavorite,
          );

          verifyInOrder([
            database.getItem(key: KeysConstants.favoritesKey),
            database.setItem(
                key: KeysConstants.favoritesKey, data: setItemData),
          ]);
        },
      );
    });
    group('getListFavoritesFromDatabase', () {
      test(
        'Success',
        () async {
          final databaseAnwser = {
            KeysConstants.listFavoritesKey: [
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 200000,
              },
            ]
          };

          when(
            database.getItem(key: KeysConstants.favoritesKey),
          ).thenAnswer(
            (_) async => databaseAnwser,
          );

          final result = await repository.getListFavoritesFromDatabase();

          expect(result, isNotNull);
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(result.first, isA<Map<String, dynamic>>());
          expect(result.first["id"], isA<String>());
          expect(result.first["name"], isA<String>());
          expect(result.first["description"], isA<String>());
          expect(result.first["creationDate"], isA<String>());
          expect(result.first["language"], isA<String>());
          expect(result.first["watchers"], isA<int>());
        },
      );
    });
    group('updateRepositoryInDatabase', () {
      test(
        'Nothing happen',
        () async {
          final favorite = {
            "id": "31792824",
            "name": "flutter",
            "description":
                "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            "creationDate": "2015-03-06T22:54:58.000",
            "language": "dart",
            "watchers": 200000,
          };

          final databaseAnwser = {
            KeysConstants.listFavoritesKey: [
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 200000,
              },
            ]
          };

          when(
            database.getItem(key: KeysConstants.favoritesKey),
          ).thenAnswer(
            (_) async => databaseAnwser,
          );

          final result = await repository.updateRepositoryInDatabase(
            favorite: favorite,
          );

          expect(result, isNotNull);
          expect(result, isA<Map<String, dynamic>>());
          expect(result, equals(favorite));
        },
      );
    });
  });
}
