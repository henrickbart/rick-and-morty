import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/character_search.dart';
import '../../shared/e_search_type.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_character_repository.dart';

class GetCharactersUseCase
    implements IUseCase<CharacterSearch, GetCharactersParams> {
  final ICharacterRepository _repository;

  GetCharactersUseCase(this._repository);

  @override
  Future<Either<Failure, CharacterSearch>> call(
      GetCharactersParams params) async {
    return await _repository.getCharacters(
        searchType: params.searchType, query: params.query, page: params.page);
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
