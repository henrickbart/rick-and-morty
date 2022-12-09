part of 'character_portrait_cubit.dart';

abstract class CharacterPortraitState extends Equatable {
  const CharacterPortraitState();

  @override
  List<Object> get props => [];
}

class InitialState extends CharacterPortraitState {}

class LoadingState extends CharacterPortraitState {}

class LoadedState extends CharacterPortraitState {
  final bool isFavorite;

  const LoadedState({required this.isFavorite});
}

class ErrorState extends CharacterPortraitState {
  final String message;

  const ErrorState(this.message);
}
