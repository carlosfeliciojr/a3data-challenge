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
            final newFavorite = RepositoryEntity(
              id: "31792824",
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
              isFavorite: true,
            );

            when(
              repository.saveRepositoryInDatabase(newFavorite: newFavorite),
            ).thenAnswer(
              (_) async {},
            );

            final result = await setRepositoryAsFavoriteUseCase.call(
              newFavorite: newFavorite,
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
              isFavorite: true,
            );

            final database = [
              RepositoryEntity(
                id: "31792824",
                name: "flutter",
                description:
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                creationDate: DateTime(2015, 3, 6, 22, 54, 58),
                language: CodeLanguageEnum.dart,
                watchers: 151346,
                isFavorite: false,
              )
            ];

            when(
              repository.getListFavoritesFromDatabase(),
            ).thenAnswer(
              (_) async => database,
            );

            final result = await setRepositoryAsFavoriteUseCase.call(
              newFavorite: repositoryEntity,
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
              isFavorite: true,
            );

            final databaseAnwser = [
              RepositoryEntity(
                id: "31792824",
                name: "flutter",
                description:
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                creationDate: DateTime(2015, 3, 6, 22, 54, 58),
                language: CodeLanguageEnum.dart,
                watchers: 151346,
                isFavorite: true,
              ),
            ];

            when(
              repository.getListFavoritesFromDatabase(),
            ).thenAnswer(
              (_) async => databaseAnwser,
            );

            final result = await setRepositoryAsFavoriteUseCase.call(
              newFavorite: repositoryEntity,
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
