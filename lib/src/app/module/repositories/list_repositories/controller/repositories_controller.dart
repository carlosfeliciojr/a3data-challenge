import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/models/favorite_repository_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/public_repositories_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/public_repository_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/user_model.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_favorites_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_user_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_repositories_with_languages_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/set_repository_as_favorite_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/update_list_of_repositories_with_favorites_use_case.dart';
import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/models/favorites_repositories_model.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';
import 'package:flutter/material.dart';

class RepositoriesController {
  RepositoriesController({
    required this.getListOfRepositoriesUseCase,
    required this.getListOfUserRepositoriesUseCase,
    required this.setRepositoryAsFavoriteUseCase,
    required this.getListOfFavoritesRepositoriesUseCase,
    required this.updateListOfRepositoriesWithFavoritesUseCase,
    required this.getRepositoriesWithLanguagesUseCase,
  });

  final GetListOfRepositoriesUseCase getListOfRepositoriesUseCase;
  final GetListOfUserRepositoriesUseCase getListOfUserRepositoriesUseCase;
  final SetRepositoryAsFavoriteUseCase setRepositoryAsFavoriteUseCase;
  final GetListOfFavoritesRepositoriesUseCase
      getListOfFavoritesRepositoriesUseCase;
  final UpdateListOfRepositoriesWithFavoritesUseCase
      updateListOfRepositoriesWithFavoritesUseCase;
  final GetRepositoriesWithLanguagesUseCase getRepositoriesWithLanguagesUseCase;

  final publicRepositories = PublicRepositoriesModel.instance;
  final favoritesRepositories = FavoritesRepositoriesModel.instance;
  final user = UserModel(username: '');

  Future<List<RepositoryModel>> getRepositories({
    required BuildContext context,
  }) async {
    favoritesRepositories.populateListOfRepositories(
      list: await _getFavoritesRepositoriesWithLanguages(context: context),
    );
    publicRepositories.populateListOfRepositories(
      list: await _getPublicRepositoriesWithLanguages(context: context),
    );
    final listPublicRepositoriesUpdated =
        updateListOfRepositoriesWithFavoritesUseCase(
      favorites: favoritesRepositories.list,
      repositories: publicRepositories.list,
    );
    publicRepositories.populateListOfRepositories(
      list: listPublicRepositoriesUpdated,
    );
    return publicRepositories.list;
  }

  Future<List<RepositoryEntity>> _getFavoritesRepositoriesWithLanguages({
    required BuildContext context,
  }) async {
    return await getRepositoriesWithLanguagesUseCase.call(
      assetBundle: DefaultAssetBundle.of(context),
      listRepository: await getListOfFavoritesRepositoriesUseCase.call(),
    );
  }

  Future<List<RepositoryEntity>> _getPublicRepositoriesWithLanguages({
    required BuildContext context,
  }) async {
    return await getRepositoriesWithLanguagesUseCase.call(
      assetBundle: DefaultAssetBundle.of(context),
      listRepository: await getListOfRepositoriesUseCase.call(
        params: GetListOfRepositoriesParams(
          language: "Dart",
          page: 0,
          amountPerPage: 10,
        ),
      ),
    );
  }

  Future<void> getUserRepositories({
    required BuildContext context,
    required String username,
  }) async {
    if (username.isEmpty) {
      getRepositories(context: context);
    }

    favoritesRepositories.populateListOfRepositories(
      list: await _getFavoritesRepositoriesWithLanguages(context: context),
    );
    publicRepositories.populateListOfRepositories(
        list: await getRepositoriesWithLanguagesUseCase.call(
      assetBundle: DefaultAssetBundle.of(context),
      listRepository: await getListOfUserRepositoriesUseCase.call(
        username: username,
      ),
    ));
    final listPublicRepositoriesUpdated =
        updateListOfRepositoriesWithFavoritesUseCase(
      favorites: favoritesRepositories.list,
      repositories: publicRepositories.list,
    );
    publicRepositories.populateListOfRepositories(
      list: listPublicRepositoriesUpdated,
    );
  }

  void onInputUserName({
    required BuildContext context,
    required String username,
  }) {
    user.username = username;
    if (user.username.isEmpty) {
      getRepositories(context: context);
    }
  }

  Future<void> addReporitoryToFavorites({
    required PublicRepositoryModel repository,
  }) async {
    publicRepositories.updateRepository(
      modifiedRepository: repository.copyWith(isFavorite: true),
    );
    favoritesRepositories.addFavoriteToList(
      favorite: FavoriteRepositoryModel(
        id: repository.id,
        name: repository.name,
        description: repository.description,
        creationDate: repository.creationDate,
        language: repository.language,
        watchers: repository.watchers,
      ),
    );

    await setRepositoryAsFavoriteUseCase.call(
      newFavorite: repository,
    );
  }
}
