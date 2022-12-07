import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/usecases/i_usecase.dart';
import 'package:rick_and_morty/src/modules/characters/domain/entities/character.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/get_favorites.dart';

class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

void main() {
  late GetFavoritesUseCase usecase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    usecase = GetFavoritesUseCase(favoriteRepository: mockFavoriteRepository);
  });

  const tResult = <Character>[];

  test('should get all character ids from the repository', () async {
    // arrange
    when(() => mockFavoriteRepository.getFavorites()).thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tResult));
    verify(() => mockFavoriteRepository.getFavorites());
    verifyNoMoreInteractions(mockFavoriteRepository);
  });
}
