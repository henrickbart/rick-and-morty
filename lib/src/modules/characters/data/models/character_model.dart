import 'dart:convert';

import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String origin,
    required String location,
    required String image,
    required List<String> episodes,
    required DateTime created,
    bool isFavorite = false,
  }) : super(id: id, name: name, status: status, species: species, type: type, gender: gender, origin: origin, location: location, image: image, episodes: episodes, created: created, isFavorite: isFavorite);

  /// Os parâmetros opcionais são usados para definir se o valor de 'origin' e 'location' são objetos ou strings
  /// Quando importados da API, o valor de 'origin' e 'location' são objetos
  /// Quando importados do banco de dados, o valor de 'origin' e 'location' são strings
  factory CharacterModel.fromMap(Map<String, dynamic> data, {rootOrigin = false, rootLocation = false}) => CharacterModel(
        id: data['id'] as int,
        name: data['name'] as String,
        status: data['status'] as String,
        species: data['species'] as String,
        type: data['type'] as String,
        gender: data['gender'] as String,
        origin: rootOrigin ? data['origin'] : data['origin']['name'] as String,
        location: rootLocation ? data['location'] : data['location']['name'] as String,
        image: data['image'] as String,
        episodes: (data['episode'].cast<String>() as List<String>),
        created: DateTime.parse(data['created'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin,
        'location': location,
        'image': image,
        'episode': episodes,
        'created': created.toIso8601String(),
      };

  factory CharacterModel.fromJson(String data, {rootOrigin = false, rootLocation = false}) {
    return CharacterModel.fromMap(json.decode(data) as Map<String, dynamic>, rootOrigin: rootOrigin, rootLocation: rootLocation);
  }

  String toJson() => json.encode(toMap());
}
