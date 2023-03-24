import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';

class PublicRepositoryModel extends RepositoryModel {
  PublicRepositoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.creationDate,
    required super.language,
    required super.watchers,
    required super.isFavorite,
  });

  factory PublicRepositoryModel.fromEntity({required RepositoryEntity entity}) {
    return PublicRepositoryModel(
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
  PublicRepositoryModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? creationDate,
    LanguageEntity? language,
    int? watchers,
    bool? isFavorite,
  }) {
    return PublicRepositoryModel(
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
