import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/remove_favorite.dart';

class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

void main() {
  late RemoveFavoriteUseCase usecase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    usecase = RemoveFavoriteUseCase(mockFavoriteRepository);
  });

  const tId = 11;
  const tResult = true;

  test('should remove character from the repository', () async {
    // arrange
    when(() => mockFavoriteRepository.removeFavorite(any())).thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(const RemoveFavoriteParams(tId));
    // assert
    expect(result, const Right(tResult));
    verify(() => mockFavoriteRepository.removeFavorite(tId));
    verifyNoMoreInteractions(mockFavoriteRepository);
  });
}
