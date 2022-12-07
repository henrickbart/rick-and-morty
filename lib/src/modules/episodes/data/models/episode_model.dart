import 'dart:convert';

import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({
    required int id,
    required String name,
    required String airDate,
    required String episode,
  }) : super(id: id, name: name, airDate: airDate, episode: episode);

  factory EpisodeModel.fromMap(Map<String, dynamic> data) => EpisodeModel(
        id: data['id'] as int,
        name: data['name'] as String,
        airDate: data['air_date'] as String,
        episode: data['episode'] as String,
      );

  @override
  bool get stringify => true;

  factory EpisodeModel.fromJson(String data) {
    return EpisodeModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
