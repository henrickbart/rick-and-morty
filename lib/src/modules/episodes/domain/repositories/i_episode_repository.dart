import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/episode.dart';

abstract class IEpisodeRepository {
  Future<Either<Failure, Episode>> getEpisode({required String url});
}
