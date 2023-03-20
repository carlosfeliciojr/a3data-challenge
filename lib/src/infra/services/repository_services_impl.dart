import 'package:a3data_challenge/src/infra/data_source/rest_api_data_source.dart';
import 'package:a3data_challenge/src/infra/models/repository_model.dart';
import 'package:a3data_challenge/src/infra/services/repository_services.dart';

class RepositoryServicesImpl implements RepositoryServices {
  RepositoryServicesImpl({required this.restApiDataSource});

  final RestApiDataSource restApiDataSource;

  @override
  Future<RepositoryModel> getListOfRepositories() {
    // TODO: implement getListOfRepositories
    throw UnimplementedError();
  }
}
