// ignore_for_file: public_member_api_docs, sort_constructors_first
class RepositoryEntity {
  String name;
  String description;
  DateTime creationDate;
  String language;
  int watchers;

  RepositoryEntity({
    required this.name,
    required this.description,
    required this.creationDate,
    required this.language,
    required this.watchers,
  });
}

//name, description, creation date, language and number of stars