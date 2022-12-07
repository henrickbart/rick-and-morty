import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_search_info_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tCharacterSearchInfoModel = CharacterSearchInfoModel(
    count: 826,
    pages: 42,
    next: 'https://rickandmortyapi.com/api/character?page=2',
    prev: null,
  );

  test('should return a valid CharacterSearchInfoModel when decoding the JSON', () async {
    // arrange
    final json = fixture(characterSearchInfoFixture);
    // act
    final result = CharacterSearchInfoModel.fromJson(json);
    // assert
    expect(result, tCharacterSearchInfoModel);
  });
}
