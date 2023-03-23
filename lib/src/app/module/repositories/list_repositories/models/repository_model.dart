import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';

class RepositoryModel extends RepositoryEntity {
  RepositoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.creationDate,
    required super.language,
    required super.watchers,
    this.isFavorite = false,
  });

  bool isFavorite = false;

  factory RepositoryModel.fromEntity({required RepositoryEntity entity}) {
    return RepositoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      creationDate: entity.creationDate,
      language: entity.language,
      watchers: entity.watchers,
    );
  }

  RepositoryModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? creationDate,
    CodeLanguageEnum? language,
    int? watchers,
    bool? isFavorite,
  }) {
    return RepositoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      language: language ?? this.language,
      watchers: watchers ?? this.watchers,
    );
  }
}
