import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:rick_and_morty/src/modules/favorites/data/datasources/favorite_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late FavoriteDataSource favoriteDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    favoriteDataSource = FavoriteDataSource(mockSharedPreferences);
  });

  final tCharacterModel = CharacterModel(
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
  );

  const tId = 11;
  final tKey = 11.toString();
  final tValue = tCharacterModel.toJson().toString();
  const tResult = true;

  group('addFavorite', () {
    test('should add a character in the favorites data source', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => tResult);
      // act
      final result = await favoriteDataSource.addFavorite(tCharacterModel);
      // assert
      expect(result, tResult);
      verify(() => mockSharedPreferences.setString(tKey, tValue));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw an CacheException if an Exception is thrown', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenThrow(Exception());
      // act
      final call = favoriteDataSource.addFavorite;
      // assert
      expect(() => call(tCharacterModel), throwsA(isA<CacheException>()));
    });
  });

  group('removeFavorite', () {
    test('should remove the key-value pair in the favorites data source', () async {
      // arrange
      when(() => mockSharedPreferences.remove(any())).thenAnswer((_) async => tResult);
      // act
      final result = await favoriteDataSource.removeFavorite(tId);
      // assert
      expect(result, tResult);
      verify(() => mockSharedPreferences.remove(tKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw an CacheException if an Exception is thrown', () async {
      // arrange
      when(() => mockSharedPreferences.remove(any())).thenThrow(Exception());
      // act
      final call = favoriteDataSource.removeFavorite;
      // assert
      expect(() => call(tId), throwsA(isA<CacheException>()));
    });
  });

  group('isFavorite', () {
    test('should return if a key exists in the data source', () async {
      // arrange
      when(() => mockSharedPreferences.containsKey(any())).thenReturn(tResult);
      //act
      final result = await favoriteDataSource.isFavorite(tId);
      // assert
      expect(result, tResult);
      verify(() => mockSharedPreferences.containsKey(tKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw an CacheException if an Exception is thrown', () async {
      // arrange
      when(() => mockSharedPreferences.containsKey(any())).thenThrow(Exception());
      // act
      final call = favoriteDataSource.isFavorite;
      // assert
      expect(() => call(tId), throwsA(isA<CacheException>()));
    });
  });

  group('getFavorites', () {
    test('should return a character list from the data source', () async {
      // arrange
      when(() => mockSharedPreferences.getKeys()).thenReturn({tKey});
      when(() => mockSharedPreferences.getString(any())).thenReturn(tValue);

      // act
      final result = await favoriteDataSource.getFavorites();

      // assert
      expect(result, [tCharacterModel]);
      verify(() => mockSharedPreferences.getKeys());
      verify(() => mockSharedPreferences.getString(tKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw an CacheException if an Exception is thrown', () async {
      // arrange
      when(() => mockSharedPreferences.getKeys()).thenThrow(Exception());
      when(() => mockSharedPreferences.getString(any())).thenThrow(Exception());
      // act
      final call = favoriteDataSource.getFavorites;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
