import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class RemoveFavoriteUseCase implements IUseCase<bool, RemoveFavoriteParams> {
  final IFavoriteRepository favoriteRepository;

  RemoveFavoriteUseCase({required this.favoriteRepository});

  @override
  Future<Either<Failure, bool>> call(RemoveFavoriteParams params) async {
    return await favoriteRepository.removeFavorite(id: params.id);
  }
}

class RemoveFavoriteParams {
  const RemoveFavoriteParams({required this.id});

  final int id;
}
