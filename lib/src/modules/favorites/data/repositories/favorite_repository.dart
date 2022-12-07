import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';

import '../../../../core/errors/failures.dart';
import '../../../characters/data/models/character_model.dart';
import '../../domain/repositories/i_favorite_repository.dart';
import '../datasources/favorite_data_source.dart';

class FavoriteRepository implements IFavoriteRepository {
  final IFavoriteDataSource favoriteDataSource;

  FavoriteRepository({required this.favoriteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getFavorites() async {
    try {
      final favorites = (await favoriteDataSource.getFavorites()).map((e) => e.copyWith(isFavorite: true)).toList();
      return Right(favorites);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addFavorite({required Character character}) async {
    try {
      final characterModel = CharacterModel(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        type: character.type,
        gender: character.gender,
        origin: character.origin,
        location: character.location,
        image: character.image,
        episodes: character.episodes,
        created: character.created,
      );
      return Right(await favoriteDataSource.addFavorite(character: characterModel));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite({required int id}) async {
    try {
      return Right(await favoriteDataSource.isFavorite(id: id));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavorite({required int id}) async {
    try {
      return Right(await favoriteDataSource.removeFavorite(id: id));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
