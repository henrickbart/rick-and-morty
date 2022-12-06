import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/modules/episodes/domain/entities/episode.dart';
import 'package:rick_and_morty/src/modules/episodes/domain/repositories/i_episode_repository.dart';
import 'package:rick_and_morty/src/modules/episodes/domain/usecases/get_episode_use_case.dart';

class MockEpisodeRepository extends Mock implements IEpisodeRepository {}

void main() {
  late GetEpisodeUseCase usecase;
  late MockEpisodeRepository mockEpisodeRepository;

  setUp(() {
    mockEpisodeRepository = MockEpisodeRepository();
    usecase = GetEpisodeUseCase(mockEpisodeRepository);
  });

  const tUrl = 'https://rickandmortyapi.com/api/episode/1';
  const tEpisode = Episode(id: 1, name: 'Pilot', airDate: 'December 2, 2013', episode: "S01E01");

  test('should get episode from the repository', () async {
    // arrange
    when(() => mockEpisodeRepository.getEpisode(any())).thenAnswer((_) async => const Right(tEpisode));
    // act
    final result = await usecase(const GetEpisodeParams(tUrl));
    // assert
    expect(result, const Right(tEpisode));
    verify(() => mockEpisodeRepository.getEpisode(tUrl));
    verifyNoMoreInteractions(mockEpisodeRepository);
  });
}
