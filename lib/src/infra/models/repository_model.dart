import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';

class RepositoryModel extends RepositoryEntity {
  RepositoryModel({
    required super.name,
    required super.description,
    required super.creationDate,
    required super.language,
    required super.watchers,
  });
}
