import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class AddFavoriteUseCase implements IUseCase<bool, AddFavoriteParams> {
  final IFavoriteRepository favoriteRepository;

  AddFavoriteUseCase({required this.favoriteRepository});

  @override
  Future<Either<Failure, bool>> call(AddFavoriteParams params) async {
    return await favoriteRepository.addFavorite(character: params.character);
  }
}

class AddFavoriteParams {
  const AddFavoriteParams({required this.character});

  final Character character;
}
