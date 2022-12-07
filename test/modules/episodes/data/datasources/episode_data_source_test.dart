import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/constants/network.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/modules/episodes/data/datasources/episode_data_source.dart';
import 'package:rick_and_morty/src/modules/episodes/data/models/episode_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late MockHttpClient mockHttpClient;
  late EpisodeDataSource episodeDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    episodeDataSource = EpisodeDataSource(mockHttpClient);
  });

  void setUpHttpClientSuccess200(String url, String fixture) {
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => Response(data: fixture, statusCode: 200, requestOptions: RequestOptions(path: url)));
  }

  void setUpHttpClientFailure404(String url) {
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => Response(data: 'There is nothing here', statusCode: 404, requestOptions: RequestOptions(path: url)));
  }

  void setUpHttpClientFailure500(String url) {
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => Response(data: 'Internal server erro', statusCode: 500, requestOptions: RequestOptions(path: url)));
  }

  const tId = 11;
  const tUrl = '$baseURL$episodeURL/$tId';
  final tEpisodeFixture = fixture(episodeFixture);
  final tEpisodeModel = EpisodeModel.fromJson(tEpisodeFixture);

  test('should perform a GET request on a URL passing the query parameters', () {
    // arrange
    setUpHttpClientSuccess200(tUrl, tEpisodeFixture);
    // act
    episodeDataSource.getEpisode(tUrl);
    // assert
    verify(
      () => mockHttpClient.get(tUrl),
    );
  });

  test('should return EpisodeModel when the response code is 200', () async {
    // arrange
    setUpHttpClientSuccess200(tUrl, tEpisodeFixture);
    // act
    final result = await episodeDataSource.getEpisode(tUrl);
    // assert
    expect(result, tEpisodeModel);
  });

  test('should return a NotFoundException when the response code is 404', () async {
    // arrange
    setUpHttpClientFailure404(tUrl);
    // act
    final call = episodeDataSource.getEpisode;
    // assert
    expect(() => call(tUrl), throwsA(isInstanceOf<NotFoundException>()));
  });

  test('should return a ServerException when the response code is 500 or other', () async {
    // arrange
    setUpHttpClientFailure500(tUrl);
    // act
    final call = episodeDataSource.getEpisode;
    // assert
    expect(() => call(tUrl), throwsA(isInstanceOf<ServerException>()));
  });
}
