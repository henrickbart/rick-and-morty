import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class GetFavoritesUseCase implements IUseCase<List<Character>, NoParams> {
  final IFavoriteRepository _repository;

  GetFavoritesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Character>>> call(NoParams params) async {
    return await _repository.getFavorites();
  }
}
