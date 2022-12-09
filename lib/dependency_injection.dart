// Service Locator
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/src/core/widgets/character_portrait/bloc/character_portrait_cubit.dart';
import 'package:rick_and_morty/src/modules/characters/data/datasources/character_data_source.dart';
import 'package:rick_and_morty/src/modules/characters/data/repositories/character_repository.dart';
import 'package:rick_and_morty/src/modules/characters/domain/repositories/i_character_repository.dart';
import 'package:rick_and_morty/src/modules/characters/domain/usecases/get_character_use_case.dart';
import 'package:rick_and_morty/src/modules/episodes/data/datasources/episode_data_source.dart';
import 'package:rick_and_morty/src/modules/episodes/data/repositories/episode_repository.dart';
import 'package:rick_and_morty/src/modules/episodes/domain/repositories/i_episode_repository.dart';
import 'package:rick_and_morty/src/modules/episodes/domain/usecases/get_episode_use_case.dart';
import 'package:rick_and_morty/src/modules/favorites/data/datasources/favorite_data_source.dart';
import 'package:rick_and_morty/src/modules/favorites/data/repositories/favorite_repository.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/add_favorite.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/get_favorites.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/remove_favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/modules/characters/domain/usecases/get_characters_use_case.dart';
import 'src/modules/characters/presentation/character_list/bloc/character_list_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> injectDependencies() async {
  //! Modules
  //!---- Characters

  //Blocs
  serviceLocator.registerFactory(() => CharacterListBloc(getCharactersUseCase: serviceLocator()));

  // sl.registerFactory(
  //   () => CharacterListBloc(
  //     getCharactersUseCase: sl()
  //   )
  // );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetCharactersUseCase(characterRepository: serviceLocator(), favoriteRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCharacterUseCase(characterRepository: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<ICharacterRepository>(() => CharacterRepository(characterDataSource: serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<ICharacterDataSource>(() => CharacterDataSource(httpClient: serviceLocator()));

  //!---- Favorites

  //Blocs
  //sl.registerFactory(
  //   () => CharacterListBloc(
  //     getCharactersUseCase: sl()
  //   )
  // );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetFavoritesUseCase(favoriteRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddFavoriteUseCase(favoriteRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => RemoveFavoriteUseCase(favoriteRepository: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<IFavoriteRepository>(() => FavoriteRepository(favoriteDataSource: serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<IFavoriteDataSource>(() => FavoriteDataSource(sharedPreferences: serviceLocator()));

  //!---- Episodes

  //Blocs
  // sl.registerFactory(
  //   () => CharacterListBloc(
  //     getCharactersUseCase: sl()
  //   )
  // );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetEpisodeUseCase(episodeRepository: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<IEpisodeRepository>(() => EpisodeRepository(episodeDataSource: serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<IEpisodeDataSource>(() => EpisodeDataSource(httpClient: serviceLocator()));

  //! Core
  //Blocs
  serviceLocator.registerFactory(() => CharacterPortraitCubit(
        addFavoriteUseCase: serviceLocator(),
        removeFavoriteUseCase: serviceLocator(),
      ));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingletonAsync(() async => sharedPreferences);
  serviceLocator.registerLazySingleton(() => Dio());
}
