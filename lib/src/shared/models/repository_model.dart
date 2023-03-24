import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';

abstract class RepositoryModel extends RepositoryEntity {
  RepositoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.creationDate,
    required super.language,
    required super.watchers,
    required super.isFavorite,
  });

  RepositoryModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? creationDate,
    LanguageEntity? language,
    int? watchers,
    bool? isFavorite,
  });
}
