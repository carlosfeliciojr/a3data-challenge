import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';

class FavoriteRepositoryModel extends RepositoryModel {
  FavoriteRepositoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.creationDate,
    required super.language,
    required super.watchers,
    super.isFavorite = true,
  });

  factory FavoriteRepositoryModel.fromEntity({
    required RepositoryEntity entity,
  }) {
    return FavoriteRepositoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      creationDate: entity.creationDate,
      language: entity.language,
      watchers: entity.watchers,
      isFavorite: entity.isFavorite,
    );
  }

  @override
  FavoriteRepositoryModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? creationDate,
    CodeLanguageEnum? language,
    int? watchers,
    bool? isFavorite,
  }) {
    return FavoriteRepositoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      language: language ?? this.language,
      watchers: watchers ?? this.watchers,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
