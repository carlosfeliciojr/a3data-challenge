import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:a3data_challenge/src/domain/usecases/get_list_of_repositories_use_case.dart';

class MockRepositoryRepository extends Mock implements RepositoryRepository {}

void main() {
  group('GetListOfRepositoriesUseCase', () {
    setUpAll(() {
      registerFallbackValue(CodeLanguageEnum.dart);
    });

    late RepositoryRepository repository;
    late GetListOfRepositoriesUseCase getListOfRepositoriesUseCase;

    setUp(() {
      repository = MockRepositoryRepository();
      getListOfRepositoriesUseCase = GetListOfRepositoriesUseCase(
        repository: repository,
      );
    });

    test(
      'getListOfRepositoriesUseCase',
      () {
        when(
          () async => repository.getListOfRepositories(
            language: any(named: 'language'),
            page: any(named: 'page'),
            amountPerPage: any(named: 'amountPerPage'),
          ),
        ).thenAnswer(
          (_) async => [
            RepositoryEntity(
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
            ),
          ],
        );

        expect(
          getListOfRepositoriesUseCase.call(
            language: CodeLanguageEnum.dart,
            page: 1,
            amountPerPage: 1,
          ),
          equals([
            RepositoryEntity(
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
            ),
          ]),
        );

        verify(() => getListOfRepositoriesUseCase.call(
              language: any(),
              page: 1,
              amountPerPage: 1,
            )).called(1);
      },
    );
  });
}
