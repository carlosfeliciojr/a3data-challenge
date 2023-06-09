import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/core/constants/services_contants.dart';
import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';
import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:a3data_challenge/src/shared/utils/map_tricks.dart';
import 'package:a3data_challenge/src/shared/utils/string_tricks.dart';
import 'package:flutter/material.dart';

class RepositoryServicesImpl implements RepositoryServices {
  RepositoryServicesImpl({required this.http});

  final Http http;

  @override
  Future<List<RepositoryEntity>> getListOfRepositories({
    required GetListOfRepositoriesParams params,
  }) async {
    final listQueryParams = [
      params.language,
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
          language: LanguageEntity(
            name: repository["language"],
            color: Colors.transparent,
          ),
          watchers: repository["watchers"] as int,
          isFavorite: false,
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
            language: LanguageEntity(
              name: repository["language"] ?? "Undentified",
              color: Colors.transparent,
            ),
            watchers: repository["watchers"] as int,
            isFavorite: false,
          );
          return repositoryEntity;
        },
      ).toList();
      return listRepositoriesEntity;
    } catch (e) {
      return [];
    }
  }
}
