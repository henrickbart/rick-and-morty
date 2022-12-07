import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_search_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCharacterSearchModel = CharacterSearchModel(characters: [
    CharacterModel(
      id: 11,
      name: 'Albert Einstein',
      status: 'Dead',
      species: 'Human',
      type: '',
      gender: 'Male',
      origin: 'Earth (C-137)',
      location: 'Earth (Replacement Dimension)',
      image: 'https://rickandmortyapi.com/api/character/avatar/11.jpeg',
      episodes: const ["https://rickandmortyapi.com/api/episode/12"],
      created: DateTime.parse('2017-11-04T20:20:20.965Z'),
    )
  ], previousPage: null, nextPage: null);

  test('should return a valid CharacterSearchModel when decoding the JSON', () async {
    // arrange
    final json = fixture(characterSearchFixture);
    // act
    final result = CharacterSearchModel.fromJson(json);
    // assert
    expect(result, tCharacterSearchModel);
  });
}
