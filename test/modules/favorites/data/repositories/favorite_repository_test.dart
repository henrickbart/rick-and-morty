import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/core/errors/failures.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:rick_and_morty/src/modules/favorites/data/datasources/favorite_data_source.dart';
import 'package:rick_and_morty/src/modules/favorites/data/repositories/favorite_repository.dart';

class MockFavoriteDataSource extends Mock implements IFavoriteDataSource {}

late MockFavoriteDataSource mockFavoriteDataSource;
late FavoriteRepository favoriteRepository;

void main() {
  final tCharacter = CharacterModel(
      id: 11,
      name: 'Albert Einstein',
      status: 'Dead',
      species: 'Human',
      type: '',
      gender: 'Male',
      origin: 'Earth (C-137)',
      location: 'Earth (Replacement Dimension)',
      image: 'https://rickandmortyapi.com/api/character/avatar/11.jpeg',
      episodes: const ["https://rickandmortyapi.com/api/episode/12"],
      created: DateTime.parse('2017-11-04T20:20:20.965Z'),
      isFavorite: true);

  const tId = 11;
  const tResult = true;

  setUp(() {
    mockFavoriteDataSource = MockFavoriteDataSource();
    favoriteRepository = FavoriteRepository(mockFavoriteDataSource);
    registerFallbackValue(tCharacter);
  });

  group('getFavorites', () {
    test('should return a list of favorites when call to repository is successful', () async {
      // arrange
      when(() => mockFavoriteDataSource.getFavorites()).thenAnswer((_) async => [tCharacter]);
      // act
      final result = await favoriteRepository.getFavorites();
      // assert
      verify(() => favoriteRepository.getFavorites());
      expect(result, Right([tCharacter]));
    });

    test('should return a CacheFailure when call to repository is unsuccessful', () async {
      // arrange
      when(() => mockFavoriteDataSource.getFavorites()).thenThrow(CacheException('Inner exception'));
      // act
      final result = await favoriteRepository.getFavorites();
      // assert
      verify(() => favoriteRepository.getFavorites());
      expect(result, CacheFailure());
    });
  });

  group('addFavorite', () {
    test('should add favorite when call to repository is successful', () async {
      // arrange
      when(() => mockFavoriteDataSource.addFavorite(any())).thenAnswer((_) async => tResult);
      // act
      final result = await favoriteRepository.addFavorite(tCharacter);
      // assert
      verify(() => favoriteRepository.addFavorite(tCharacter));
      expect(result, const Right(tResult));
    });

    test('should return a CacheFailure when call to repository is unsuccessful', () async {
      // arrange
      when(() => mockFavoriteDataSource.addFavorite(any())).thenThrow(CacheException('Inner exception'));
      // act
      final result = await favoriteRepository.addFavorite(tCharacter);
      // assert
      verify(() => favoriteRepository.addFavorite(tCharacter));
      expect(result, Left(CacheFailure()));
    });
  });

  group('removeFavorite', () {
    test('should remove favorite when call to repository is successful', () async {
      // arrange
      when(() => mockFavoriteDataSource.removeFavorite(any())).thenAnswer((_) async => tResult);
      // act
      final result = await favoriteRepository.removeFavorite(tId);
      // assert
      verify(() => favoriteRepository.removeFavorite(tId));
      expect(result, const Right(tResult));
    });

    test('should return a CacheFailure when call to repository is unsuccessful', () async {
      // arrange
      when(() => mockFavoriteDataSource.removeFavorite(any())).thenThrow(CacheException('Inner exception'));
      // act
      final result = await favoriteRepository.removeFavorite(tId);
      // assert
      verify(() => favoriteRepository.removeFavorite(tId));
      expect(result, Left(CacheFailure()));
    });
  });

  group('isFavorite', () {
    test('should return if the character is in the repository', () async {
      // arrange
      when(() => mockFavoriteDataSource.isFavorite(any())).thenAnswer((_) async => tResult);
      // act
      final result = await favoriteRepository.isFavorite(tId);
      // assert
      verify(() => favoriteRepository.isFavorite(tId));
      expect(result, const Right(tResult));
    });

    test('should return a CacheFailure when call to repository is unsuccessful', () async {
      // arrange
      when(() => mockFavoriteDataSource.isFavorite(any())).thenThrow(CacheException('Inner exception'));
      // act
      final result = await favoriteRepository.isFavorite(tId);
      // assert
      verify(() => favoriteRepository.isFavorite(tId));
      expect(result, Left(CacheFailure()));
    });
  });
}
