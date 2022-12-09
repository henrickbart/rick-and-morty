part of 'character_list_bloc.dart';

abstract class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object> get props => [];
}

class InitialState extends CharacterListState {}

class EmptyState extends CharacterListState {
  final String message;

  const EmptyState(this.message);
}

class DataState extends CharacterListState {
  final List<Character> characters;
  final bool hasMore;

  const DataState({required this.characters, required this.hasMore});
}

class LoadingState extends DataState {
  const LoadingState({required List<Character> characters, required bool hasMore}) : super(characters: characters, hasMore: hasMore);
}

class LoadedState extends DataState {
  const LoadedState({required List<Character> characters, required bool hasMore}) : super(characters: characters, hasMore: hasMore);
}

class ErrorState extends CharacterListState {
  final String message;

  const ErrorState(this.message);
}
