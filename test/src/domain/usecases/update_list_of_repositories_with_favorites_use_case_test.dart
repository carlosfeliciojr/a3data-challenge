import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/usecases/update_list_of_repositories_with_favorites_use_case.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_list_of_repositories_with_favorites_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UpdateListOfRepositoriesWithFavoritesUseCase>()])
void main() {
  final UpdateListOfRepositoriesWithFavoritesUseCase
      updateListOfRepositoriesWithFavoritesUseCase =
      MockUpdateListOfRepositoriesWithFavoritesUseCase();

  group(
    'UpdateListOfRepositoriesWithFavoritesUseCase',
    () {
      test(
        'success - with data',
        () async {
          final repositories = [
            RepositoryEntity(
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
              isFavorite: false,
            ),
          ];

          final favorites = [
            RepositoryEntity(
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
            ),
          ];

          final expectedAnswer = [
            RepositoryEntity(
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
            ),
          ];

          when(
            updateListOfRepositoriesWithFavoritesUseCase.call(
              repositories: repositories,
              favorites: favorites,
            ),
          ).thenReturn(expectedAnswer);

          final result = updateListOfRepositoriesWithFavoritesUseCase.call(
            repositories: repositories,
            favorites: favorites,
          );

          expect(result, isNotNull);
          expect(result, isA<List<RepositoryEntity>>());
          expect(result.first, isA<RepositoryEntity>());
          expect(result.first.name, isA<String>());
          expect(result.first.description, isA<String>());
          expect(result.first.creationDate, isA<DateTime>());
          expect(result.first.language, isA<LanguageEntity>());
          expect(result.first.watchers, isA<int>());
          expect(result.first.isFavorite, isA<bool>());
          expect(result.first.isFavorite, isTrue);
        },
      );

      test(
        'success - empty data',
        () async {
          final repositories = <RepositoryEntity>[];
          final favorites = <RepositoryEntity>[];
          final expectedAnswer = <RepositoryEntity>[];

          when(
            updateListOfRepositoriesWithFavoritesUseCase.call(
              repositories: repositories,
              favorites: favorites,
            ),
          ).thenReturn(expectedAnswer);

          final result = updateListOfRepositoriesWithFavoritesUseCase.call(
            repositories: repositories,
            favorites: favorites,
          );

          expect(result, isNotNull);
          expect(result, isA<List<RepositoryEntity>>());
          expect(result, equals([]));
        },
      );
    },
  );
}
