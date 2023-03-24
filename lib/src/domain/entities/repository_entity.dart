import 'package:a3data_challenge/src/domain/entities/language_entity.dart';

class RepositoryEntity {
  String id;
  String name;
  String? description;
  DateTime creationDate;
  LanguageEntity language;
  int watchers;
  bool isFavorite;

  RepositoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.language,
    required this.watchers,
    required this.isFavorite,
  });
}
