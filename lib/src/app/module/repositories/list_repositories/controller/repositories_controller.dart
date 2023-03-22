import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/repositories_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/repository_model.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/user_model.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_repositories_use_case.dart';
import 'package:a3data_challenge/src/domain/usecases/get_list_of_user_repositories_use_case.dart';
import 'package:flutter/foundation.dart';

class RepositoriesController extends ChangeNotifier {
  RepositoriesController({
    required this.getListOfRepositoriesUseCase,
    required this.getListOfUserRepositoriesUseCase,
  });

  final GetListOfRepositoriesUseCase getListOfRepositoriesUseCase;
  final GetListOfUserRepositoriesUseCase getListOfUserRepositoriesUseCase;

  final repositories = RepositoriesModel();
  final user = UserModel(username: '');

  Future<List<RepositoryModel>> getRepositories() async {
    final result = await getListOfRepositoriesUseCase.call(
      params: GetListOfRepositoriesParams(
        language: CodeLanguageEnum.dart,
        page: 0,
        amountPerPage: 10,
      ),
    );
    repositories.populateListOfRepositories(listOfRepositories: result);
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
}
