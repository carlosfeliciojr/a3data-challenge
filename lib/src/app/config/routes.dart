import 'package:a3data_challenge/src/app/config/dependencies_injection.dart';
import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/view/favorite_repositories_view.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/view/list_repositories_view.dart';

class Routes {
  static const listRepositories = "/";
  static const listFavoritesRepositories = "/favoritesRepositories";

  static final paths = {
    listRepositories: (context) => getIt.get<ListRepositoriesView>(),
    listFavoritesRepositories: (context) =>
        getIt.get<FavoritesRepositoriesView>(),
  };
}
