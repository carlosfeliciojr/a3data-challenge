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
