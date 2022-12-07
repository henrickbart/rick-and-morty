import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/src/modules/episodes/data/models/episode_model.dart';
import 'package:rick_and_morty/src/modules/episodes/domain/entities/episode.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    id: 1,
    name: 'Pilot',
    airDate: 'December 2, 2013',
    episode: 'S01E01',
  );

  test('should be a subclass of Episode entity', () {
    // assert
    expect(tEpisodeModel, isA<Episode>());
  });

  test('should return a valid EpisodeModel when decoding the JSON', () async {
    // arrange
    final json = fixture(episodeFixture);
    // act
    final result = EpisodeModel.fromJson(json);
    // assert
    expect(result, tEpisodeModel);
  });
}
