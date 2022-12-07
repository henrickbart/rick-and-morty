import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../entities/episode.dart';
import '../repositories/i_episode_repository.dart';

class GetEpisodeUseCase implements IUseCase<Episode, GetEpisodeParams> {
  final IEpisodeRepository episodeRepository;

  GetEpisodeUseCase({required this.episodeRepository});

  @override
  Future<Either<Failure, Episode>> call(GetEpisodeParams params) async {
    return await episodeRepository.getEpisode(url: params.url);
  }
}

class GetEpisodeParams {
  const GetEpisodeParams({required this.url});

  final String url;
}
