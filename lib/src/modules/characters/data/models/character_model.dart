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

  @override
  Character copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? origin,
    String? location,
    String? image,
    List<String>? episodes,
    DateTime? created,
    bool? isFavorite,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episodes: episodes ?? this.episodes,
      created: created ?? this.created,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory CharacterModel.fromJson(String data, {rootOrigin = false, rootLocation = false}) {
    return CharacterModel.fromMap(json.decode(data) as Map<String, dynamic>, rootOrigin: rootOrigin, rootLocation: rootLocation);
  }

  String toJson() => json.encode(toMap());
}
