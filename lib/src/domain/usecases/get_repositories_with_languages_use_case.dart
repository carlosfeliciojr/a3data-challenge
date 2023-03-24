import 'dart:convert';

import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:flutter/material.dart';

class GetRepositoriesWithLanguagesUseCase {
  Future<List<RepositoryEntity>> call({
    required AssetBundle assetBundle,
    required List<RepositoryEntity> listRepository,
  }) async {
    final languagesMap = jsonDecode(
      await assetBundle.loadString(
        "assets/jsons/languages_colors.json",
      ),
    );
    for (final repository in listRepository) {
      languagesMap.forEach(
        (language, value) {
          if (repository.language.name == language) {
            String? colorsString = value["color"];
            if (colorsString != null) {
              final color = Color(int.parse(
                colorsString.replaceAll("#", "0xFF"),
              ));
              repository.language = repository.language = LanguageEntity(
                name: language,
                color: color,
              );
              return;
            }

            repository.language = repository.language = LanguageEntity(
              name: language,
            );
          }
        },
      );
    }

    return listRepository;
  }
}
