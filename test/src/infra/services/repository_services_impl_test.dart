import 'dart:developer';

import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/infra/models/repository_model.dart';
import 'package:a3data_challenge/src/infra/repositories/repository_repository_impl.dart';
import 'package:a3data_challenge/src/infra/requests/get_list_of_repositories_request.dart';
import 'package:a3data_challenge/src/infra/services/repository_services.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repository_services_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RepositoryServices>()])
void main() {
  final RepositoryServices services = MockRepositoryServices();
  final RepositoryRepositoryImpl repository =
      RepositoryRepositoryImpl(services: services);

  group('RepositoryRepositoryImpl', () {
    group(
      'GetListOfRepositoriesUseCase',
      () {
        final params = GetListOfRepositoriesParams(
          language: CodeLanguageEnum.dart,
          page: 1,
          amountPerPage: 1,
        );
        final request = GetListOfRepositoriesRequest.fromParams(
          params: params,
        );

        test(
          'sucess - with data',
          () async {
            final repositoryEntity = RepositoryEntity(
              name: "flutter",
              description:
                  "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
              creationDate: DateTime(2015, 3, 6, 22, 54, 58),
              language: CodeLanguageEnum.dart,
              watchers: 151346,
            );
            final repositoryAnswer = [repositoryEntity];
            final serviceAnswer = [
              RepositoryModel.fromEntity(entity: repositoryEntity)
            ];

            when(
              services.getListOfRepositories(request: request),
            ).thenAnswer(
              (_) async => serviceAnswer,
            );

            final result = await repository.getListOfRepositories(
              params: params,
            );

            expect(result, isNotNull);
            expect(result, isA<List<RepositoryEntity>>());
            expect(result, equals(repositoryAnswer));
          },
        );
      },
    );
  });
}
