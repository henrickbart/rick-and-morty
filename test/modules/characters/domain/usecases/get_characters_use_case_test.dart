import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character_search.dart';
import 'package:rick_and_morty/src/modules/characters/domain/repositories/i_character_repository.dart';
import 'package:rick_and_morty/src/modules/characters/domain/usecases/get_characters_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/src/modules/characters/shared/e_search_type.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';

class MockCharacterRepository extends Mock implements ICharacterRepository {}

class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

void main() {
  late GetCharactersUseCase usecase;
  late MockCharacterRepository mockCharacterRepository;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    mockFavoriteRepository = MockFavoriteRepository();
    usecase = GetCharactersUseCase(characterRepository: mockCharacterRepository, favoriteRepository: mockFavoriteRepository);
  });

  const tSearchType = ESearchType.name;
  const tId = 11;
  const tQuery = 'Rick';
  const tPage = 1;
  final tCharacter = Character(
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
      isFavorite: false);

  final CharacterSearch tCharacterSearch = CharacterSearch([tCharacter], null, null);

  test('should get list of characters from the repository', () async {
    // arrange
    when(() => mockCharacterRepository.getCharacters(searchType: any(named: 'searchType'), query: any(named: 'query'), page: any(named: 'page'))).thenAnswer((_) async => Right(tCharacterSearch));
    // act
    final result = await usecase(const GetCharactersParams(searchType: tSearchType, query: tQuery, page: tPage));
    // assert
    expect(result, Right(tCharacterSearch));
    verify(() => mockCharacterRepository.getCharacters(searchType: tSearchType, query: tQuery, page: tPage));
    verifyNoMoreInteractions(mockCharacterRepository);
  });

  test('should get list of characters from the repository with favorites', () async {
    // arrange
    when(() => mockCharacterRepository.getCharacters(searchType: any(named: 'searchType'), query: any(named: 'query'), page: any(named: 'page'))).thenAnswer((_) async => Right(tCharacterSearch));
    when((() => mockFavoriteRepository.isFavorite(id: any()))).thenAnswer((_) async => const Right(true));
    // act
    final result = await usecase(const GetCharactersParams(searchType: tSearchType, query: tQuery, page: tPage));
    // assert
    expect(result, Right(tCharacterSearch));
    expect(result.fold((l) => l, (r) => r.characters.first.isFavorite), true);
    verify(() => mockCharacterRepository.getCharacters(searchType: tSearchType, query: tQuery, page: tPage));
    verify(() => mockFavoriteRepository.isFavorite(id: tId));
    verifyNoMoreInteractions(mockCharacterRepository);
    verifyNoMoreInteractions(mockFavoriteRepository);
  });
}
