import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';
import 'package:rick_and_morty/src/modules/characters/domain/repositories/i_character_repository.dart';
import 'package:rick_and_morty/src/modules/characters/domain/usecases/get_character_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCharacterRepository extends Mock implements ICharacterRepository {}

void main() {
  late GetCharacterUseCase usecase;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    usecase = GetCharacterUseCase(characterRepository: mockCharacterRepository);
  });

  const tId = 11;
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

  test('should get a character from the repository', () async {
    // arrange
    when(() => mockCharacterRepository.getCharacter(id: any(named: 'id'))).thenAnswer((_) async => Right(tCharacter));
    // act
    final result = await usecase(const GetCharacterParams(id: tId));
    // assert
    expect(result, Right(tCharacter));
    verify(() => mockCharacterRepository.getCharacter(id: tId));
    verifyNoMoreInteractions(mockCharacterRepository);
  });
}
