import 'package:a3data_challenge/src/core/constants/services_contants.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';
import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:a3data_challenge/src/shared/utils/string_tricks.dart';

class RepositoryServicesImpl implements RepositoryServices {
  RepositoryServicesImpl({required this.http});

  final Http http;

  @override
  Future<List<RepositoryEntity>> getListOfRepositories({
    required GetListOfRepositoriesParams params,
  }) async {
    final listQueryParams = [
      params.language.text,
      params.page,
      params.amountPerPage
    ];
    final url = StringTricks.replaceTextWithValues(
      text: ServicesConstants.searchRepositoryEndPoint,
      values: listQueryParams,
    );

    final response = await http.get(url: url);
    final listRepositories =
        response["listFavorites"] as List<Map<String, dynamic>>;
    return listRepositories
        .map(
          (repository) => RepositoryEntity(
            id: repository["id"],
            name: repository["name"],
            description: repository["description"],
            creationDate: DateTime.parse(repository["creationDate"]).toLocal(),
            language: CodeLanguageEnum.fromText(text: repository["language"]),
            watchers: repository["watchers"] as int,
          ),
        )
        .toList();
  }
}
