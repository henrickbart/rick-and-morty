import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/core/errors/failures.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/add_favorite.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/remove_favorite.dart';
part 'character_portrait_state.dart';

class CharacterPortraitCubit extends Cubit<CharacterPortraitState> {
  CharacterPortraitCubit({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(InitialState());

  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;

  void toggleFavorite(Character character) async {
    emit(LoadingState());

    if (character.isFavorite) {
      var result = await removeFavoriteUseCase(RemoveFavoriteParams(id: character.id));
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (value) => emit(const LoadedState(isFavorite: false)),
      );
    } else {
      var result = await addFavoriteUseCase(AddFavoriteParams(character: character));
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (value) => emit(const LoadedState(isFavorite: true)),
      );
    }
  }
}
