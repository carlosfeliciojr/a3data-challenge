import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/controller/favorites_repositories_controller.dart';
import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/view/favorite_repositories_view.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/controller/repositories_controller.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/view/list_repositories_view.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_favorites_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_user_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_repositories_with_languages_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/remove_favorite_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/set_repository_as_favorite_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/update_list_of_repositories_with_favorites_use_case.dart';
import 'package:a3data_challenge/src/external/datasource/dart_http_impl.dart';
import 'package:a3data_challenge/src/external/drivers/shared_preferences_database.dart';
import 'package:a3data_challenge/src/infra/drivers/database.dart';
import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:a3data_challenge/src/infra/repositories/repository_repository_impl.dart';
import 'package:a3data_challenge/src/infra/services/repository_services_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

class DependenciesInjection {
  static Future<void> registerDependencies() async {
    await _registerDatasources();
    _registerRepositories();
    _registerUseCases();
    _registerControllers();
    _registerViews();
  }
}

Future<void> _registerDatasources() async {
  getIt.registerSingleton<Http>(
    DartHttp(http: http.Client()),
  );
  getIt.registerSingleton<Database>(
    SharedPreferencesDatabase(
      sharedPreferences: await SharedPreferences.getInstance(),
    ),
  );
}

void _registerRepositories() {
  getIt.registerSingleton<RepositoryServices>(
    RepositoryServicesImpl(http: getIt.get<Http>()),
  );
  getIt.registerSingleton<RepositoryRepository>(
    RepositoryRepositoryImpl(database: getIt.get<Database>()),
  );
}

void _registerUseCases() {
  getIt.registerSingleton<GetListOfRepositoriesUseCase>(
    GetListOfRepositoriesUseCase(
      repository: getIt.get<RepositoryServices>(),
    ),
  );
  getIt.registerSingleton<GetListOfUserRepositoriesUseCase>(
    GetListOfUserRepositoriesUseCase(
      services: getIt.get<RepositoryServices>(),
    ),
  );
  getIt.registerSingleton<SetRepositoryAsFavoriteUseCase>(
    SetRepositoryAsFavoriteUseCase(
      repository: getIt.get<RepositoryRepository>(),
    ),
  );
  getIt.registerSingleton<GetListOfFavoritesRepositoriesUseCase>(
    GetListOfFavoritesRepositoriesUseCase(
      repository: getIt.get<RepositoryRepository>(),
    ),
  );
  getIt.registerSingleton<UpdateListOfRepositoriesWithFavoritesUseCase>(
    UpdateListOfRepositoriesWithFavoritesUseCase(),
  );
  getIt.registerSingleton<RemoveFavoriteUseCase>(
    RemoveFavoriteUseCase(repository: getIt.get<RepositoryRepository>()),
  );
  getIt.registerSingleton<GetRepositoriesWithLanguagesUseCase>(
    GetRepositoriesWithLanguagesUseCase(),
  );
}

void _registerControllers() {
  getIt.registerFactory<RepositoriesController>(
    () => RepositoriesController(
      getListOfRepositoriesUseCase: getIt.get<GetListOfRepositoriesUseCase>(),
      getListOfUserRepositoriesUseCase:
          getIt.get<GetListOfUserRepositoriesUseCase>(),
      setRepositoryAsFavoriteUseCase:
          getIt.get<SetRepositoryAsFavoriteUseCase>(),
      getListOfFavoritesRepositoriesUseCase:
          getIt.get<GetListOfFavoritesRepositoriesUseCase>(),
      updateListOfRepositoriesWithFavoritesUseCase:
          getIt.get<UpdateListOfRepositoriesWithFavoritesUseCase>(),
      getRepositoriesWithLanguagesUseCase:
          getIt.get<GetRepositoriesWithLanguagesUseCase>(),
    ),
  );

  getIt.registerFactory<FavoritesRepositoriesController>(
    () => FavoritesRepositoriesController(
      getListOfFavoritesRepositoriesUseCase:
          getIt.get<GetListOfFavoritesRepositoriesUseCase>(),
      removeFavoriteUseCase: getIt.get<RemoveFavoriteUseCase>(),
    ),
  );
}

void _registerViews() {
  getIt.registerFactory(
    () => ListRepositoriesView(
      controller: getIt.get<RepositoriesController>(),
    ),
  );
  getIt.registerFactory(
    () => FavoritesRepositoriesView(
      controller: getIt.get<FavoritesRepositoriesController>(),
    ),
  );
}
