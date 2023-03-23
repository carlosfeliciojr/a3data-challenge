import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/public_repositories_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/user_model.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_favorites_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_user_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/set_repository_as_favorite_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/update_list_of_repositories_with_favorites_use_case.dart';
import 'package:a3data_challenge/src/shared/models/favorites_repositories_model.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';
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

  final publicRepositories = PublicRepositoriesModel();
  final favoritesRepositories = FavoritesRepositoriesModel.instance;
  final user = UserModel(username: '');

  Future<List<RepositoryModel>> getRepositories() async {
    favoritesRepositories.populateListOfRepositories(
      list: await getListOfFavoritesRepositoriesUseCase.call(),
    );
    publicRepositories.populateListOfRepositories(
      list: await getListOfRepositoriesUseCase.call(
        params: GetListOfRepositoriesParams(
          language: CodeLanguageEnum.dart,
          page: 0,
          amountPerPage: 10,
        ),
      ),
    );
    final listRepositories = updateListOfRepositoriesWithFavoritesUseCase(
      favorites: favoritesRepositories.list,
      repositories: publicRepositories.list,
    );
    publicRepositories.populateListOfRepositories(
      list: listRepositories,
    );
    notifyListeners();
    return publicRepositories.list;
  }

  Future<void> getUserRepositories({required String username}) async {
    favoritesRepositories.populateListOfRepositories(
      list: await getListOfFavoritesRepositoriesUseCase.call(),
    );
    publicRepositories.populateListOfRepositories(
      list: await getListOfUserRepositoriesUseCase.call(
        username: username,
      ),
    );
    final listRepositories = updateListOfRepositoriesWithFavoritesUseCase(
      favorites: favoritesRepositories.list,
      repositories: publicRepositories.list,
    );
    favoritesRepositories.populateListOfRepositories(list: listRepositories);
    notifyListeners();
  }

  void onInputUserName(String username) {
    user.username = username;
    if (user.username.isEmpty) {
      getRepositories();
    }
  }

  Future<void> addReporitoryToFavorites({
    required RepositoryModel repository,
  }) async {
    publicRepositories.updateRepository(
      modifiedRepository: repository.copyWith(isFavorite: true),
    );
    favoritesRepositories.updateRepository(modifiedRepository: repository);

    await setRepositoryAsFavoriteUseCase.call(
      newFavorite: repository,
    );
    notifyListeners();
  }
}
