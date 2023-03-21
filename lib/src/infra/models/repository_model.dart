import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';

class RepositoryModel extends RepositoryEntity {
  RepositoryModel({
    required super.name,
    required super.description,
    required super.creationDate,
    required super.language,
    required super.watchers,
  });

  factory RepositoryModel.fromEntity({required RepositoryEntity entity}) {
    return RepositoryModel(
      name: entity.name,
      description: entity.description,
      creationDate: entity.creationDate,
      language: entity.language,
      watchers: entity.watchers,
    );
  }
}
