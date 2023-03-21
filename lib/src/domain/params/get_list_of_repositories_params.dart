import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';

class GetListOfRepositoriesParams {
  final CodeLanguageEnum language;
  final int page;
  final int amountPerPage;

  GetListOfRepositoriesParams({
    required this.language,
    required this.page,
    required this.amountPerPage,
  });
}
