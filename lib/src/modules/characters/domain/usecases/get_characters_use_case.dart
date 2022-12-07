import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';
import '../entities/character_search.dart';
import '../../shared/e_search_type.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_character_repository.dart';

class GetCharactersUseCase implements IUseCase<CharacterSearch, GetCharactersParams> {
  final ICharacterRepository characterRepository;
  final IFavoriteRepository favoriteRepository;

  GetCharactersUseCase({required this.characterRepository, required this.favoriteRepository});

  @override
  Future<Either<Failure, CharacterSearch>> call(GetCharactersParams params) async {
    final result = await characterRepository.getCharacters(searchType: params.searchType, query: params.query, page: params.page);

    //Consultando se os personagens da lista estão favoritados
    if (result.isRight()) {
      final characterSearch = result.getOrElse(() => const CharacterSearch([], 0, 2));

      for (var character in characterSearch.characters) {
        final result = await favoriteRepository.isFavorite(id: character.id);

        if (result.isRight()) {
          final isFavorite = result.getOrElse(() => false);

          var newCharacter = character.copyWith(isFavorite: isFavorite);
          characterSearch.characters[characterSearch.characters.indexOf(character)] = newCharacter;
        }
      }
      return Right(characterSearch);
    }
    return result;
  }
}

class GetCharactersParams extends Equatable {
  const GetCharactersParams({this.searchType, this.query, this.page});

  final ESearchType? searchType;
  final String? query;
  final int? page;

  @override
  List<Object?> get props => [searchType, query, page];
}
