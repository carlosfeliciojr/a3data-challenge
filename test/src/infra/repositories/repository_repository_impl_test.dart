import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/infra/drivers/asset_json.dart';
import 'package:a3data_challenge/src/infra/repositories/repository_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:a3data_challenge/src/infra/drivers/database.dart';

import 'repository_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Database>(), MockSpec<AssetJson>()])
void main() {
  final Database database = MockDatabase();
  final AssetJson assetJson = MockAssetJson();

  final RepositoryRepositoryImpl repository = RepositoryRepositoryImpl(
    database: database,
  );

  group('RepositoryRepositoryImpl', () {
    group('saveRepositoryInDatabase', () {
      test(
        'Success',
        () async {
          final getItemData = <dynamic>[
            {
              "id": "31792824",
              "name": "flutter",
              "description":
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              "creationDate": "2015-03-06T22:54:58.000",
              "language": {"name": "Dart", "color": 0xFF00B4AB},
              "watchers": 151346,
              "isFavorite": true,
            }
          ];

          when(
            database.getItem(key: KeysConstants.itemsKey),
          ).thenAnswer(
            (_) async => getItemData,
          );

          final setItemData = [
            {
              "id": "31792824",
              "name": "flutter",
              "description":
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              "creationDate": "2015-03-06T22:54:58.000",
              "language": {"name": "Dart", "color": 0xFF00B4AB},
              "watchers": 151346,
              "isFavorite": true,
            },
            {
              "id": "31792824",
              "name": "flutter",
              "description":
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              "creationDate": "2015-03-06T22:54:58.000",
              "language": {"name": "Dart", "color": 0xFF00B4AB},
              "watchers": 151346,
              "isFavorite": true,
            }
          ];

          when(
            database.setItem(key: KeysConstants.itemsKey, data: setItemData),
          ).thenAnswer(
            (_) async => true,
          );

          final newFavorite = RepositoryEntity(
            id: "31792824",
            name: "flutter",
            description:
                "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            creationDate: DateTime(2015, 3, 6, 22, 54, 58),
            language: LanguageEntity(
              name: "Dart",
              color: const Color(0xFF00B4AB),
            ),
            watchers: 151346,
            isFavorite: true,
          );

          await repository.saveRepositoryInDatabase(
            newFavorite: newFavorite,
          );

          verifyInOrder([
            database.getItem(key: KeysConstants.itemsKey),
            database.setItem(key: KeysConstants.itemsKey, data: setItemData),
          ]);
        },
      );
    });
    group('getListFavoritesFromDatabase', () {
      test(
        'Success',
        () async {
          final databaseAnwser = <dynamic>[
            {
              "id": "31792824",
              "name": "flutter",
              "description":
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              "creationDate": "2015-03-06T22:54:58.000",
              "language": {"name": "Dart", "color": 0xFF00B4AB},
              "watchers": 200000,
              "isFavorite": true,
            },
          ];

          when(
            database.getItem(key: KeysConstants.itemsKey),
          ).thenAnswer(
            (_) async => databaseAnwser,
          );

          final result = await repository.getListFavoritesFromDatabase();

          expect(result, isNotNull);
          expect(result, isA<List<RepositoryEntity>>());
          expect(result.first, isA<RepositoryEntity>());
          expect(result.first.id, isA<String>());
          expect(result.first.name, isA<String>());
          expect(result.first.description, isA<String>());
          expect(result.first.creationDate, isA<DateTime>());
          expect(result.first.language, isA<LanguageEntity>());
          expect(result.first.watchers, isA<int>());
          expect(result.first.isFavorite, isA<bool>());
        },
      );
    });
    group('updateRepositoryInDatabase', () {
      test(
        'Nothing happen',
        () async {
          final databaseAnwser = <dynamic>[
            {
              "id": "31792824",
              "name": "flutter",
              "description":
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              "creationDate": "2015-03-06T22:54:58.000",
              "language": {"name": "Dart", "color": 0xFF00B4AB},
              "watchers": 200000,
              "isFavorite": true,
            },
          ];

          final favorite = RepositoryEntity(
            id: "31792824",
            name: "flutter",
            description:
                "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            creationDate: DateTime(2015, 3, 6, 22, 54, 58),
            language: LanguageEntity(
              name: "Dart",
              color: const Color(0xFF00B4AB),
            ),
            watchers: 200000,
            isFavorite: true,
          );

          when(
            database.getItem(key: KeysConstants.itemsKey),
          ).thenAnswer(
            (_) async => databaseAnwser,
          );

          final result = await repository.updateRepositoryInDatabase(
            modifiedFavorite: favorite,
          );

          expect(result, isNull);
        },
      );
    });

    group('removeFavoriteInDatabase', () {
      test(
        'Success',
        () async {
          final databaseItemData = <dynamic>[
            {
              "id": "31792824",
              "name": "flutter",
              "description":
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              "creationDate": "2015-03-06T22:54:58.000",
              "language": {"name": "Dart", "color": 0xFF00B4AB},
              "watchers": 200000,
              "isFavorite": true,
            },
          ];

          when(
            database.getItem(key: KeysConstants.itemsKey),
          ).thenAnswer(
            (_) async => databaseItemData,
          );

          final steItemData = <dynamic>[];

          when(
            database.setItem(key: KeysConstants.itemsKey, data: steItemData),
          ).thenAnswer(
            (_) async => true,
          );

          final favorite = RepositoryEntity(
            id: "31792824",
            name: "flutter",
            description:
                "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            creationDate: DateTime(2015, 3, 6, 22, 54, 58),
            language: LanguageEntity(
              name: "Dart",
              color: const Color(0xFF00B4AB),
            ),
            watchers: 200000,
            isFavorite: true,
          );

          final result = await repository.removeFavoriteInDatabase(
            unfavored: favorite,
          );

          expect(result, isNotNull);
          expect(result, isA<StatusEnum>());
          expect(result, equals(StatusEnum.success));
        },
      );
    });
  });
}
