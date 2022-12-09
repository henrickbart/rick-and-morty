import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../datasources/character_data_source.dart';
import '../../domain/entities/character.dart';
import '../../domain/entities/character_search.dart';
import '../../shared/e_search_type.dart';

import '../../domain/repositories/i_character_repository.dart';

class CharacterRepository implements ICharacterRepository {
  final ICharacterDataSource characterDataSource;

  CharacterRepository({required this.characterDataSource});

  @override
  Future<Either<Failure, CharacterSearch>> getCharacters({ESearchType? searchType, String? query, int? page}) async {
    try {
      final characterSearchModel = await characterDataSource.getCharacters(searchType: searchType, query: query, page: page);

      //Transforming a CharacterSearchModel in a CharacterSearch
      final characterSearch = characterSearchModel.copyWith(characters: characterSearchModel.characters.map((character) => character.copyWith()).toList());

      return Right(characterSearch);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacter({required int id}) async {
    try {
      final character = await characterDataSource.getCharacter(id: id);
      return Right(character);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
