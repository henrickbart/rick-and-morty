import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class RemoveFavoriteUseCase implements IUseCase<bool, RemoveFavoriteParams> {
  final IFavoriteRepository _repository;

  RemoveFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(RemoveFavoriteParams params) async {
    return await _repository.removeFavorite(params.id);
  }
}

class RemoveFavoriteParams {
  const RemoveFavoriteParams(this.id);

  final int id;
}
