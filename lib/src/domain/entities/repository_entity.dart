import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';

class RepositoryEntity {
  String id;
  String name;
  String? description;
  DateTime creationDate;
  CodeLanguageEnum language;
  int watchers;
  // bool isFavorite;

  RepositoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.language,
    required this.watchers,
    // required this.isFavorite,
  });
}
