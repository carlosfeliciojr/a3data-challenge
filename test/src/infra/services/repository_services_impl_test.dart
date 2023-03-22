import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/core/constants/services_contants.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:a3data_challenge/src/infra/services/repository_services_impl.dart';
import 'package:a3data_challenge/src/shared/utils/string_tricks.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'repository_services_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Http>()])
void main() {
  final Http http = MockHttp();
  final RepositoryServicesImpl service = RepositoryServicesImpl(http: http);
  group('RepositoryServicesImpl', () {
    group(
      'getListOfRepositories',
      () {
        final params = GetListOfRepositoriesParams(
          language: CodeLanguageEnum.dart,
          page: 1,
          amountPerPage: 1,
        );

        test(
          'Success - With data',
          () async {
            final listQueryParams = [
              params.language.text,
              params.page,
              params.amountPerPage
            ];

            final httpAnswer = {
              KeysConstants.itemsKey: [
                {
                  "id": 31792824,
                  "name": "flutter",
                  "description":
                      "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                  "created_at": "2015-03-07T01:54:58.000Z",
                  "language": "Dart",
                  "watchers": 151346
                },
              ]
            };

            final url = StringTricks.replaceTextWithValues(
              text: ServicesConstants.searchRepositoryEndPoint,
              values: listQueryParams,
            );

            when(
              http.get(url: url),
            ).thenAnswer(
              (_) async => httpAnswer,
            );

            final result = await service.getListOfRepositories(
              params: params,
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
      },
    );

    group(
      'getListOfUserRepositories',
      () {
        test(
          'Success - With data',
          () async {
            final listQueryParams = ["carlosfeliciojr"];

            final httpAnswer = <dynamic>[
              {
                "id": 31792824,
                "name": "flutter",
                "description":
                    "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
                "created_at": "2015-03-07T01:54:58.000Z",
                "language": "Dart",
                "watchers": 151346
              },
            ];

            final url = StringTricks.replaceTextWithValues(
              text: ServicesConstants.getUserRepositories,
              values: listQueryParams,
            );

            when(
              http.get(url: url),
            ).thenAnswer(
              (_) async => httpAnswer,
            );

            final result = await service.getListOfUserRepositories(
              username: "carlosfeliciojr",
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
      },
    );
  });
}
