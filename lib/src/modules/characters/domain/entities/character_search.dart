import 'package:equatable/equatable.dart';

import 'character.dart';

class CharacterSearch extends Equatable {
  final List<Character> characters;
  final int? previousPage;
  final int? nextPage;

  const CharacterSearch(this.characters, this.previousPage, this.nextPage);

  @override
  List<Object?> get props => [characters, previousPage, nextPage];
}
