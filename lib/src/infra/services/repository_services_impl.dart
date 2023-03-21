import 'package:a3data_challenge/src/core/services_contants.dart';
import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:a3data_challenge/src/infra/models/repository_model.dart';
import 'package:a3data_challenge/src/infra/requests/get_list_of_repositories_request.dart';
import 'package:a3data_challenge/src/infra/services/repository_services.dart';
import 'package:a3data_challenge/src/shared/utils/string_tricks.dart';

class RepositoryServicesImpl implements RepositoryServices {
  RepositoryServicesImpl({required this.http});

  final Http http;

  @override
  Future<List<RepositoryModel>> getListOfRepositories({
    required GetListOfRepositoriesRequest request,
  }) async {
    final listQueryParams = [
      request.language.text,
      request.page,
      request.amountPerPage
    ];
    final url = StringTricks.replaceTextWithValues(
      text: ServicesConstants.searchRepositoryEndPoint,
      values: listQueryParams,
    );

    final response = await http.get(url: url);
    final listRepositories = response["items"] as List<Map<String, dynamic>>;
    return listRepositories
        .map(
          (repository) => RepositoryModel(
            name: repository["name"],
            description: repository["description"],
            creationDate: repository["creationDate"],
            language: repository["language"],
            watchers: repository["watchers"],
          ),
        )
        .toList();
  }
}
