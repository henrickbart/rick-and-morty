import 'package:dio/dio.dart';

import '../../../../core/constants/network.dart';
import '../models/character_model.dart';
import '../models/character_search_model.dart';
import '../../shared/e_search_type.dart';

import '../../../../core/errors/exceptions.dart';

abstract class ICharacterDataSource {
  Future<CharacterSearchModel> getCharacters(
      {ESearchType? searchType, String? query, int? page});
  Future<CharacterModel> getCharacter(int id);
}

class CharacterDataSource implements ICharacterDataSource {
  final Dio httpClient;

  CharacterDataSource(this.httpClient);
  @override
  Future<CharacterSearchModel> getCharacters(
      {ESearchType? searchType, String? query, int? page}) async {
    var queryParams = {
      if (page != null) 'page': page.toString(),
      if (query != null && searchType != null) searchType.name: query,
    };

    final response = await httpClient.get('$baseURL$characterURL',
        queryParameters: queryParams);

    if (response.statusCode == 200) {
      return CharacterSearchModel.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    final response = await httpClient.get('$baseURL$characterURL/$id');

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
