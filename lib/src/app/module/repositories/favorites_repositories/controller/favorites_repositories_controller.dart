import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/models/favorite_repository_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/models/favorites_repositories_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/public_repositories_model.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_favorites_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/remove_favorite_use_case.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';

class FavoritesRepositoriesController {
  FavoritesRepositoriesController({
    required this.getListOfFavoritesRepositoriesUseCase,
    required this.removeFavoriteUseCase,
  });

  final GetListOfFavoritesRepositoriesUseCase
      getListOfFavoritesRepositoriesUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;

  final favoritesRepositories = FavoritesRepositoriesModel.instance;
  final publicRepositories = PublicRepositoriesModel.instance;

  Future<List<RepositoryModel>> getFavoritesRepositories() async {
    final listFavoritesRepositories =
        await getListOfFavoritesRepositoriesUseCase.call();

    favoritesRepositories.populateListOfRepositories(
      list: listFavoritesRepositories,
    );

    return favoritesRepositories.list;
  }

  Future<void> removeFavorite({
    required FavoriteRepositoryModel unfavored,
  }) async {
    favoritesRepositories.removeFavoriteFromList(unfavored: unfavored);
    publicRepositories.updateRepository(
      modifiedRepository: unfavored.copyWith(isFavorite: false),
    );
    await removeFavoriteUseCase.call(unfavored: unfavored);
  }
}
