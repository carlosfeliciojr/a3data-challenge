import 'package:a3data_challenge/src/infra/models/repository_model.dart';

abstract class RepositoryServices {
  Future<RepositoryModel> getListOfRepositories();
}
