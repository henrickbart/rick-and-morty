import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/src/core/constants/network.dart';
import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/modules/characters/data/datasources/character_data_source.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_search_model.dart';
import 'package:rick_and_morty/src/modules/characters/shared/e_search_type.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late MockHttpClient mockHttpClient;
  late CharacterDataSource characterDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    characterDataSource = CharacterDataSource(httpClient: mockHttpClient);
  });

  void setUpHttpClientSuccess200(String url, String fixture) {
    when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => Response(data: fixture, statusCode: 200, requestOptions: RequestOptions(path: url)));
  }

  void setUpHttpClientFailure404(String url) {
    when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => Response(data: 'There is nothing here', statusCode: 404, requestOptions: RequestOptions(path: url)));
  }

  void setUpHttpClientFailure500(String url) {
    when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => Response(data: 'Internal server error', statusCode: 500, requestOptions: RequestOptions(path: url)));
  }

  group('getCharacters', () {
    const tSearchType = ESearchType.name;
    const tQuery = 'Albert';
    const tPage = 1;

    final tUrl = '$baseURL$characterURL?${tSearchType.name}=$tQuery&page=$tPage';

    final tCharacterSearchFixture = fixture(characterSearchFixture);
    final tCharacterSearchModel = CharacterSearchModel.fromJson(tCharacterSearchFixture);

    test('should perform a GET request on a URL passing the query parameters', () {
      // arrange
      setUpHttpClientSuccess200(tUrl, tCharacterSearchFixture);
      // act
      characterDataSource.getCharacters(searchType: tSearchType, query: tQuery, page: tPage);
      // assert
      verify(
        () => mockHttpClient.get('$baseURL$characterURL', queryParameters: {tSearchType.name: tQuery, 'page': tPage.toString()}),
      );
    });

    test('should return CharacterSearchModel when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200(tUrl, tCharacterSearchFixture);
      // act
      final result = await characterDataSource.getCharacters(searchType: tSearchType, query: tQuery, page: tPage);
      // assert
      expect(result, tCharacterSearchModel);
    });

    test('should return a NotFoundException when the response code is 404', () async {
      // arrange
      setUpHttpClientFailure404(tUrl);
      // act
      final call = characterDataSource.getCharacters;
      // assert
      expect(() => call(searchType: tSearchType, query: tQuery, page: tPage), throwsA(isInstanceOf<NotFoundException>()));
    });

    test('should return a ServerException when the response code is 500 or other', () async {
      // arrange
      setUpHttpClientFailure500(tUrl);
      // act
      final call = characterDataSource.getCharacters;
      // assert
      expect(() => call(searchType: tSearchType, query: tQuery, page: tPage), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getCharacter', () {
    const tId = 11;

    const tUrl = '$baseURL$characterURL/$tId';
    final tCharacterFixture = fixture(characterFixture);
    final tCharacterModel = CharacterModel.fromJson(tCharacterFixture);

    test('should perform a GET request on a URL passing the query parameters', () {
      // arrange
      setUpHttpClientSuccess200(tUrl, tCharacterFixture);
      // act
      characterDataSource.getCharacter(id: tId);
      // assert
      verify(
        () => mockHttpClient.get(tUrl),
      );
    });

    test('should return CharacterModel when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200(tUrl, tCharacterFixture);
      // act
      final result = await characterDataSource.getCharacter(id: tId);
      // assert
      expect(result, tCharacterModel);
    });

    test('should return a NotFoundException when the response code is 404', () async {
      // arrange
      setUpHttpClientFailure404(tUrl);
      // act
      final call = characterDataSource.getCharacter;
      // assert
      expect(() => call(id: tId), throwsA(isInstanceOf<NotFoundException>()));
    });

    test('should return a ServerException when the response code is 500 or other', () async {
      // arrange
      setUpHttpClientFailure500(tUrl);
      // act
      final call = characterDataSource.getCharacter;
      // assert
      expect(() => call(id: tId), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
