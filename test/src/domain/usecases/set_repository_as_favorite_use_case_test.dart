import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/domain/usecases/set_repository_as_favorite_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'set_repository_as_favorite_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RepositoryRepository>()])
void main() {
  final RepositoryRepository repository = MockRepositoryRepository();
  final SetRepositoryAsFavoriteUseCase setRepositoryAsFavoriteUseCase =
      SetRepositoryAsFavoriteUseCase(repository: repository);

  group('RepositoryRepositoryImpl', () {
    group(
      'saveFavoriteRepository',
      () {
        test(
          'Success',
          () async {
            final repositoryEntity = RepositoryEntity(
              id: "31792824",
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
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

            when(
              repository.saveRepositoryInDatabase(newFavorite: newFavorite),
            ).thenAnswer(
              (_) async {},
            );

            final result = await setRepositoryAsFavoriteUseCase.call(
              repository: repositoryEntity,
            );

            expect(result, isNotNull);
            expect(result, isA<StatusEnum>());
            expect(result, equals(StatusEnum.success));
          },
        );

        test(
          'Update favorites',
          () async {
            final repositoryEntity = RepositoryEntity(
              id: "31792824",
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
            );

            final database = [
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 200000,
              }
            ];

            when(
              repository.getListFavoritesFromDatabase(),
            ).thenAnswer(
              (_) async => database,
            );

            final result = await setRepositoryAsFavoriteUseCase.call(
              repository: repositoryEntity,
            );

            expect(result, isNotNull);
            expect(result, isA<StatusEnum>());
            expect(result, equals(StatusEnum.updated));
          },
        );

        test(
          'Nothing happen',
          () async {
            final repositoryEntity = RepositoryEntity(
              id: "31792824",
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
            );

            final databaseAnwser = [
              {
                "id": "31792824",
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "creationDate": "2015-03-06T22:54:58.000",
                "language": "dart",
                "watchers": 151346,
              },
            ];

            when(
              repository.getListFavoritesFromDatabase(),
            ).thenAnswer(
              (_) async => databaseAnwser,
            );

            final result = await setRepositoryAsFavoriteUseCase.call(
              repository: repositoryEntity,
            );

            expect(result, isNotNull);
            expect(result, isA<StatusEnum>());
            expect(result, equals(StatusEnum.none));
          },
        );
      },
    );
  });
}