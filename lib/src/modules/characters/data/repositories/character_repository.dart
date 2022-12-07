import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../datasources/character_data_source.dart';
import '../../domain/entities/character.dart';
import '../../domain/entities/character_search.dart';
import '../../shared/e_search_type.dart';

import '../../domain/repositories/i_character_repository.dart';

class CharacterRepository implements ICharacterRepository {
  final ICharacterDataSource _characterDataSource;

  CharacterRepository(this._characterDataSource);

  @override
  Future<Either<Failure, CharacterSearch>> getCharacters(
      {ESearchType? searchType, String? query, int? page}) async {
    try {
      final characters = await _characterDataSource.getCharacters(
          searchType: searchType, query: query, page: page);
      return Right(characters);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacter(int id) async {
    try {
      final character = await _characterDataSource.getCharacter(id);
      return Right(character);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
