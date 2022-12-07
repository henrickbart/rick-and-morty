import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/add_favorite.dart';

class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

void main() {
  late AddFavoriteUseCase usecase;
  late MockFavoriteRepository mockFavoriteRepository;

  const tResult = true;
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

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    usecase = AddFavoriteUseCase(favoriteRepository: mockFavoriteRepository);
    registerFallbackValue(tCharacter);
  });

  test('should add character id in the repository', () async {
    // arrange
    when(() => mockFavoriteRepository.addFavorite(character: any(named: 'character'))).thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(AddFavoriteParams(character: tCharacter));
    // assert
    expect(result, const Right(tResult));
    verify(() => mockFavoriteRepository.addFavorite(character: tCharacter));
    verifyNoMoreInteractions(mockFavoriteRepository);
  });
}
