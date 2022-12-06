import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class AddFavoriteUseCase implements IUseCase<bool, AddFavoriteParams> {
  final IFavoriteRepository _repository;

  AddFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(AddFavoriteParams params) async {
    return await _repository.addFavorite(params.character);
  }
}

class AddFavoriteParams {
  const AddFavoriteParams(this.character);

  final Character character;
}
