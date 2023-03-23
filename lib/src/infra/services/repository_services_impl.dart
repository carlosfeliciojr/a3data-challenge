import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/core/constants/services_contants.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';
import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:a3data_challenge/src/shared/utils/map_tricks.dart';
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
    final listRepositoriesMap = MapTricks.convertDynamicToListMap(
      response[KeysConstants.itemsKey],
    );
    final listRepositoriesEntity = listRepositoriesMap.map(
      (repository) {
        final repositoryEntity = RepositoryEntity(
          id: repository["id"].toString(),
          name: repository["name"],
          description: repository["description"],
          creationDate: DateTime.parse(repository["created_at"]).toLocal(),
          language: CodeLanguageEnum.fromText(text: repository["language"]),
          watchers: repository["watchers"] as int,
          // isFavorite: repository["isFavorite"] as bool,
        );
        return repositoryEntity;
      },
    );
    return listRepositoriesEntity.toList();
  }

  @override
  Future<List<RepositoryEntity>> getListOfUserRepositories({
    required String username,
  }) async {
    try {
      final url = StringTricks.replaceTextWithValues(
        text: ServicesConstants.getUserRepositories,
        values: [username],
      );

      final response = await http.get(url: url);
      final listRepositoriesMap = MapTricks.convertDynamicToListMap(response);
      final listRepositoriesEntity = listRepositoriesMap.map(
        (repository) {
          final repositoryEntity = RepositoryEntity(
            id: repository["id"].toString(),
            name: repository["name"],
            description: repository["description"],
            creationDate: DateTime.parse(repository["created_at"]).toLocal(),
            language:
                CodeLanguageEnum.fromText(text: repository["language"] ?? ''),
            watchers: repository["watchers"] as int,
            // isFavorite: repository["isFavorite"],
          );
          return repositoryEntity;
        },
      );
      return listRepositoriesEntity.toList();
    } catch (e) {
      return [];
    }
  }
}
