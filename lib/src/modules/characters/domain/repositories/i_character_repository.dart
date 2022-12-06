import 'package:dartz/dartz.dart';
import '../entities/character_search.dart';
import '../../shared/e_search_type.dart';

import '../../../../core/errors/failures.dart';
import '../entities/character.dart';

abstract class ICharacterRepository {
  Future<Either<Failure, CharacterSearch>> getCharacters(
      {ESearchType? searchType, String? query, int? page});

  Future<Either<Failure, Character>> getCharacter(int id);
}
