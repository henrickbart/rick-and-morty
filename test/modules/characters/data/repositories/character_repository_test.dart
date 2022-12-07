import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/core/errors/failures.dart';
import 'package:rick_and_morty/src/modules/characters/data/datasources/character_data_source.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_search_model.dart';
import 'package:rick_and_morty/src/modules/characters/data/repositories/character_repository.dart';

class MockCharacterDataSource extends Mock implements ICharacterDataSource {}

void main() {
  late MockCharacterDataSource mockCharacterDataSource;
  late CharacterRepository characterRepository;

  setUp(() {
    mockCharacterDataSource = MockCharacterDataSource();
    characterRepository = CharacterRepository(mockCharacterDataSource);
  });

  const tQuery = 'Rick';
  const tPage = 1;
  const tCharacterSearchModel = CharacterSearchModel(characters: [], previousPage: null, nextPage: null);

  const tId = 11;
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

  test('should get characters when call to search characters in data source is successful', () async {
    // arrange
    when(() => mockCharacterDataSource.getCharacters(query: any(named: 'query'), page: any(named: 'page'))).thenAnswer((_) async => tCharacterSearchModel);
    // act
    final result = await characterRepository.getCharacters(query: tQuery, page: tPage);
    // assert
    verify(() => mockCharacterDataSource.getCharacters(query: tQuery, page: tPage));
    expect(result, const Right(tCharacterSearchModel));
  });

  test('should get a NotFoundFailure when call to search characters in data source is unsuccessful', () async {
    // arrange
    when(() => mockCharacterDataSource.getCharacters(query: any(named: 'query'), page: any(named: 'page'))).thenThrow(NotFoundException());
    // act
    final result = await characterRepository.getCharacters(query: tQuery, page: tPage);
    // assert
    verify(() => mockCharacterDataSource.getCharacters(query: tQuery, page: tPage));
    expect(result, Left(NotFoundFailure()));
  });

  test('should get a ServerFailure when call to search characters in data source is unsuccessful', () async {
    // arrange
    when(() => mockCharacterDataSource.getCharacters(query: any(named: 'query'), page: any(named: 'page'))).thenThrow(ServerException());
    // act
    final result = await characterRepository.getCharacters(query: tQuery, page: tPage);
    // assert
    verify(() => mockCharacterDataSource.getCharacters(query: tQuery, page: tPage));
    expect(result, Left(ServerFailure()));
  });

  test('should get character data when call to get character in data source is successful', () async {
    // arrange
    when(() => mockCharacterDataSource.getCharacter(any())).thenAnswer((_) async => tCharacterModel);
    // act
    final result = await characterRepository.getCharacter(tId);
    // assert
    verify(() => mockCharacterDataSource.getCharacter(tId));
    expect(result, Right(tCharacterModel));
  });

  test('should get NotFoundFailure when call to get character in data source is unsuccessful', () async {
    // arrange
    when(() => mockCharacterDataSource.getCharacter(tId)).thenThrow(NotFoundException());
    // act
    final result = await characterRepository.getCharacter(tId);
    // assert
    verify(() => mockCharacterDataSource.getCharacter(tId));
    expect(result, Left(NotFoundFailure()));
  });

  test('should get ServerFailure when call to get character in data source is unsuccessful', () async {
    // arrange
    when(() => mockCharacterDataSource.getCharacter(tId)).thenThrow(ServerException());
    // act
    final result = await characterRepository.getCharacter(tId);
    // assert
    verify(() => mockCharacterDataSource.getCharacter(tId));
    expect(result, Left(ServerFailure()));
  });
}
