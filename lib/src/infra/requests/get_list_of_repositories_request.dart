import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';

class GetListOfRepositoriesRequest extends GetListOfRepositoriesParams {
  GetListOfRepositoriesRequest({
    required super.language,
    required super.page,
    required super.amountPerPage,
  });

  factory GetListOfRepositoriesRequest.fromParams({
    required GetListOfRepositoriesParams params,
  }) {
    return GetListOfRepositoriesRequest(
      language: params.language,
      page: params.page,
      amountPerPage: params.amountPerPage,
    );
  }
}
