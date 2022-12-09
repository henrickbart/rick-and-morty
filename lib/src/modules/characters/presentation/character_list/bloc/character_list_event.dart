part of 'character_list_bloc.dart';

abstract class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  @override
  List<Object> get props => [];
}

class GetCharactersEvent extends CharacterListEvent {
  const GetCharactersEvent({this.query});

  final String? query;
}

class ChangeSearchTypeEvent extends CharacterListEvent {
  const ChangeSearchTypeEvent({required this.searchType});

  final ESearchType searchType;
}

class ToogleFavoriteEvent extends CharacterListEvent {
  const ToogleFavoriteEvent({required this.character});

  final Character character;
}
