import 'package:dio/dio.dart';
import 'package:rick_and_morty/src/modules/episodes/data/models/episode_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/episode.dart';

abstract class IEpisodeDataSource {
  Future<Episode> getEpisode({required String url});
}

class EpisodeDataSource implements IEpisodeDataSource {
  final Dio httpClient;

  EpisodeDataSource({required this.httpClient});

  @override
  Future<Episode> getEpisode({required String url}) async {
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      return EpisodeModel.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
