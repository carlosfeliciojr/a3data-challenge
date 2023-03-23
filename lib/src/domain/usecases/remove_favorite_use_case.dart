import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';

class RemoveFavoriteUseCase {
  RemoveFavoriteUseCase({required this.repository});

  final RepositoryRepository repository;

  Future<StatusEnum> call({
    required RepositoryEntity unfavored,
  }) async {
    final status = await repository.removeFavoriteInDatabase(
      unfavored: unfavored,
    );
    return status;
  }
}
