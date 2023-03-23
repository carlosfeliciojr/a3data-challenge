import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_user_repositories_use_case.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_list_of_repositories_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RepositoryServices>()])
void main() {
  final RepositoryServices services = MockRepositoryServices();
  final GetListOfUserRepositoriesUseCase getListOfUserRepositoriesUseCase =
      GetListOfUserRepositoriesUseCase(services: services);

  group(
    'GetListOfUserRepositoriesUseCase',
    () {
      final params = GetListOfRepositoriesParams(
        language: CodeLanguageEnum.dart,
        page: 1,
        amountPerPage: 1,
      );

      test(
        'success - with data',
        () async {
          final expectedAnswer = [
            RepositoryEntity(
              id: "31792824",
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
            ),
          ];

          when(
            services.getListOfUserRepositories(username: 'carlosfeliciojr'),
          ).thenAnswer(
            (_) async => expectedAnswer,
          );

          final result = await getListOfUserRepositoriesUseCase.call(
            username: 'carlosfeliciojr',
          );

          expect(result, isNotNull);
          expect(result, isA<List<RepositoryEntity>>());
          expect(result.first, isA<RepositoryEntity>());
          expect(result.first.name, isA<String>());
          expect(result.first.description, isA<String>());
          expect(result.first.creationDate, isA<DateTime>());
          expect(result.first.language, isA<CodeLanguageEnum>());
          expect(result.first.watchers, isA<int>());
        },
      );

      test(
        'success - empty data',
        () async {
          final expectedAnswer = <RepositoryEntity>[];

          when(
            services.getListOfRepositories(params: params),
          ).thenAnswer(
            (_) async => expectedAnswer,
          );

          final result = await getListOfUserRepositoriesUseCase.call(
            username: 'carlosfelicio',
          );

          expect(result, isNotNull);
          expect(result, isA<List<RepositoryEntity>>());
          expect(result, equals([]));
        },
      );
    },
  );
}
