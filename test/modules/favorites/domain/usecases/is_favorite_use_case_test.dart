import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/repositories/i_favorite_repository.dart';
import 'package:rick_and_morty/src/modules/favorites/domain/usecases/is_favorite.dart';

class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

void main() {
  late IsFavoriteUseCase usecase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    usecase = IsFavoriteUseCase(mockFavoriteRepository);
  });

  const tId = 11;
  const tResult = true;

  test('should return true if character id is in the repository', () async {
    // arrange
    when(() => mockFavoriteRepository.isFavorite(id: any(named: 'id'))).thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(const IsFavoriteParams(tId));
    // assert
    expect(result, const Right(tResult));
    verify(() => mockFavoriteRepository.isFavorite(id: tId));
    verifyNoMoreInteractions(mockFavoriteRepository);
  });
}
