import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/core/errors/failures.dart';
import 'package:rick_and_morty/src/modules/characters/domain/usecases/get_characters_use_case.dart';
import 'package:rick_and_morty/src/modules/characters/shared/e_search_type.dart';

import '../../../domain/entities/character.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  ESearchType _searchType = ESearchType.name;
  String? _query;
  int? _nextPage;

  List<Character> _characters = [];

  final GetCharactersUseCase getCharactersUseCase;
  CharacterListBloc({required this.getCharactersUseCase}) : super(InitialState()) {
    on<GetCharactersEvent>(_handleGetCharactersEvent);
    on<ChangeSearchTypeEvent>(_handleSearchTypeEvent);
    on<ToogleFavoriteEvent>(_handleToogleFavoriteEvent);
  }

  FutureOr<void> _handleGetCharactersEvent(GetCharactersEvent event, Emitter<CharacterListState> emit) async {
    emit(LoadingState(characters: _characters, hasMore: _nextPage != null));

    // If the query is different, reset the list and save the new query
    if (event.query != _query) {
      _resetList();
      _query = event.query;
    }

    final result = await getCharactersUseCase(GetCharactersParams(searchType: _searchType, query: _query, page: _nextPage));

    result.fold(
      (failure) {
        failure.runtimeType == NotFoundFailure ? emit(EmptyState(failure.message)) : emit(ErrorState(failure.message));
      },
      (characterSearch) {
        _characters += characterSearch.characters;
        _nextPage = characterSearch.nextPage;

        emit(LoadedState(characters: _characters, hasMore: _nextPage != null));
      },
    );
  }

  FutureOr<void> _handleSearchTypeEvent(ChangeSearchTypeEvent event, Emitter<CharacterListState> emit) {
    _resetList();
    _searchType = event.searchType;

    add(GetCharactersEvent(query: _query));
  }

  FutureOr<void> _handleToogleFavoriteEvent(ToogleFavoriteEvent event, Emitter<CharacterListState> emit) async {
    //emit(LoadingState(_characters, _nextPage != null));

    // if (event.character.isFavorite) {
    //   final result = await removeFavoriteUseCase(RemoveFavoriteParams(id: event.character.id));
    //   result.fold(
    //     (failure) => emit(ErrorState(failure.message)),
    //     (success) => () {},
    //   );
    // } else {
    //   final result = await addFavoriteUseCase(AddFavoriteParams(character: event.character));
    //   result.fold(
    //     (failure) => emit(ErrorState(failure.message)),
    //     (success) => () {},
    //   );
    // }

    // Updating the character list
    final character = _characters.firstWhere((element) => element.id == event.character.id);
    final index = _characters.indexOf(character);
    final newCharacter = character.copyWith(isFavorite: !character.isFavorite);
    _characters[index] = newCharacter;

    //emit(LoadedState(_characters, _nextPage != null));
  }

  void _resetList() {
    _characters = [];
    _nextPage = null;
  }
}
