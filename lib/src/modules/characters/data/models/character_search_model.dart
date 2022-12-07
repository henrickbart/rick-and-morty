import 'dart:convert';

import 'character_model.dart';
import 'character_search_info_model.dart';
import '../../domain/entities/character_search.dart';
import '../../domain/entities/character.dart';

class CharacterSearchModel extends CharacterSearch {
  const CharacterSearchModel(
      {required List<Character> characters, int? previousPage, int? nextPage})
      : super(characters, previousPage, nextPage);

  factory CharacterSearchModel.fromMap(Map<String, dynamic> data) {
    var info =
        CharacterSearchInfoModel.fromMap(data['info'] as Map<String, dynamic>);

    return CharacterSearchModel(
      characters: (data['results'] as List<dynamic>)
          .map((e) => CharacterModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      nextPage: info.next != null
          ? int.parse(Uri.parse(info.next!).queryParameters['page']!)
          : null,
      previousPage: info.prev != null
          ? int.parse(Uri.parse(info.next!).queryParameters['page']!)
          : null,
    );
  }

  factory CharacterSearchModel.fromJson(String data) {
    return CharacterSearchModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
}
