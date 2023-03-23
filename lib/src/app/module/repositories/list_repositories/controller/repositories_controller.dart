import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/repositories_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/repository_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/user_model.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_favorites_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_user_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/set_repository_as_favorite_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/update_list_of_repositories_with_favorites_use_case.dart';
import 'package:flutter/foundation.dart';

class RepositoriesController extends ChangeNotifier {
  RepositoriesController({
    required this.getListOfRepositoriesUseCase,
    required this.getListOfUserRepositoriesUseCase,
    required this.setRepositoryAsFavoriteUseCase,
    required this.getListOfFavoritesRepositoriesUseCase,
    required this.updateListOfRepositoriesWithFavoritesUseCase,
  });

  final GetListOfRepositoriesUseCase getListOfRepositoriesUseCase;
  final GetListOfUserRepositoriesUseCase getListOfUserRepositoriesUseCase;
  final SetRepositoryAsFavoriteUseCase setRepositoryAsFavoriteUseCase;
  final GetListOfFavoritesRepositoriesUseCase
      getListOfFavoritesRepositoriesUseCase;
  final UpdateListOfRepositoriesWithFavoritesUseCase
      updateListOfRepositoriesWithFavoritesUseCase;

  final repositories = RepositoriesModel();
  final user = UserModel(username: '');

  Future<List<RepositoryModel>> getRepositories() async {
    final localList = await getListOfFavoritesRepositoriesUseCase.call();
    final responseList = await getListOfRepositoriesUseCase.call(
      params: GetListOfRepositoriesParams(
        language: CodeLanguageEnum.dart,
        page: 0,
        amountPerPage: 10,
      ),
    );

    final listRepositories = updateListOfRepositoriesWithFavoritesUseCase(
      favorites: localList,
      repositories: responseList,
    );

    listRepositories.addAll(responseList);
    repositories.populateListOfRepositories(
      listOfRepositories: responseList,
    );
    notifyListeners();

    return repositories.listOfRepositories;
  }

  Future<void> getUserRepositories({required String username}) async {
    final result = await getListOfUserRepositoriesUseCase.call(
      username: username,
    );
    repositories.populateListOfRepositories(listOfRepositories: result);
    notifyListeners();
  }

  void onInputUserName(String username) {
    user.username = username;
  }

  Future<void> addReporitoryToFavorites({
    required RepositoryModel repository,
  }) async {
    repositories.updateRepository(
      modifiedRepository: repository.copyWith(isFavorite: true),
    );

    final result = await setRepositoryAsFavoriteUseCase.call(
      newFavorite: repository,
    );

    notifyListeners();
  }
}
