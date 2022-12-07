import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';

import '../../../../core/errors/failures.dart';

abstract class IFavoriteRepository {
  Future<Either<Failure, List<Character>>> getFavorites();

  Future<Either<Failure, bool>> isFavorite({required int id});

  Future<Either<Failure, bool>> addFavorite({required Character character});

  Future<Either<Failure, bool>> removeFavorite({required int id});
}
