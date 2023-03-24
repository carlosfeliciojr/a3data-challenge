import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/domain/usecases/remove_favorite_use_case.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'set_repository_as_favorite_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RepositoryRepository>()])
void main() {
  final RepositoryRepository repository = MockRepositoryRepository();
  final RemoveFavoriteUseCase removeFavoriteUseCase =
      RemoveFavoriteUseCase(repository: repository);

  group(
    'SetRepositoryAsFavoriteUseCase',
    () {
      test(
        'Success',
        () async {
          final unfavored = RepositoryEntity(
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

          when(
            repository.removeFavoriteInDatabase(unfavored: unfavored),
          ).thenAnswer(
            (_) async => StatusEnum.success,
          );

          final result = await removeFavoriteUseCase.call(
            unfavored: unfavored,
          );

          expect(result, isNotNull);
          expect(result, isA<StatusEnum>());
          expect(result, equals(StatusEnum.success));
        },
      );
    },
  );
}
