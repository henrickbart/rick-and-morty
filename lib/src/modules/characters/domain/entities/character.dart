import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String location;
  final String image;
  final List<String> episodes;
  final DateTime created;
  final bool isFavorite;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
    required this.created,
    required this.isFavorite,
  });

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

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, name, status, species, type, gender, origin, location, image, episodes, created, isFavorite];
  }
}
