import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character_search.dart';
import 'package:rick_and_morty/src/modules/characters/domain/repositories/i_character_repository.dart';
import 'package:rick_and_morty/src/modules/characters/domain/usecases/get_characters_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/src/modules/characters/shared/e_search_type.dart';

class MockCharacterRepository extends Mock implements ICharacterRepository {}

void main() {
  late GetCharactersUseCase usecase;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    usecase = GetCharactersUseCase(mockCharacterRepository);
  });

  const tSearchType = ESearchType.name;
  const tQuery = 'Rick';
  const tPage = 1;
  const CharacterSearch tCharacterSearch = CharacterSearch([], null, null);

  test('should get list of characters from the repository', () async {
    // arrange
    when(() => mockCharacterRepository.getCharacters(searchType: any(named: 'searchType'), query: any(named: 'query'), page: any(named: 'page'))).thenAnswer((_) async => const Right(tCharacterSearch));
    // act
    final result = await usecase(const GetCharactersParams(searchType: tSearchType, query: tQuery, page: tPage));
    // assert
    expect(result, const Right(tCharacterSearch));
    verify(() => mockCharacterRepository.getCharacters(searchType: tSearchType, query: tQuery, page: tPage));
    verifyNoMoreInteractions(mockCharacterRepository);
  });
}
