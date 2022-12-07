import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/core/errors/failures.dart';
import 'package:rick_and_morty/src/modules/episodes/data/datasources/episode_data_source.dart';
import 'package:rick_and_morty/src/modules/episodes/data/models/episode_model.dart';
import 'package:rick_and_morty/src/modules/episodes/data/repositories/episode_repository.dart';

class MockEpisodeDataSource extends Mock implements IEpisodeDataSource {}

void main() {
  late MockEpisodeDataSource mockEpisodeDataSource;
  late EpisodeRepository episodeRepository;

  setUp(() {
    mockEpisodeDataSource = MockEpisodeDataSource();
    episodeRepository = EpisodeRepository(mockEpisodeDataSource);
  });

  const tUrl = 'https://rickandmortyapi.com/api/episode/1';
  const tEpisodeModel = EpisodeModel(id: 1, name: 'Pilot', airDate: 'December 2, 2013', episode: "S01E01");

  test('should get episode data when call to data source is successful', () async {
    // arrange
    when(() => mockEpisodeDataSource.getEpisode(any())).thenAnswer((_) async => tEpisodeModel);
    // act
    final result = await episodeRepository.getEpisode(tUrl);
    // assert
    verify(() => mockEpisodeDataSource.getEpisode(tUrl));
    expect(result, const Right(tEpisodeModel));
  });

  test('should get NotFoundFailure when call to episode data source is unsuccessful', () async {
    // arrange
    when(() => mockEpisodeDataSource.getEpisode(any())).thenThrow(NotFoundException());
    // act
    final result = await episodeRepository.getEpisode(tUrl);
    // assert
    verify(() => mockEpisodeDataSource.getEpisode(tUrl));
    expect(result, Left(NotFoundFailure()));
  });

  test('should get ServerFailure when call to episode data source is unsuccessful', () async {
    // arrange
    when(() => mockEpisodeDataSource.getEpisode(any())).thenThrow(ServerException());
    // act
    final result = await episodeRepository.getEpisode(tUrl);
    // assert
    verify(() => mockEpisodeDataSource.getEpisode(tUrl));
    expect(result, Left(ServerFailure()));
  });
}
