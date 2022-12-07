import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/episode_data_source.dart';
import '../../domain/repositories/i_episode_repository.dart';

import '../../domain/entities/episode.dart';

class EpisodeRepository implements IEpisodeRepository {
  final IEpisodeDataSource episodeDataSource;

  EpisodeRepository({required this.episodeDataSource});
  @override
  Future<Either<Failure, Episode>> getEpisode({required String url}) async {
    try {
      final episode = await episodeDataSource.getEpisode(url: url);
      return Right(episode);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
