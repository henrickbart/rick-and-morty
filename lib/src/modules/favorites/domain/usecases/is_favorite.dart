import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class IsFavoriteUseCase implements IUseCase<bool, IsFavoriteParams> {
  final IFavoriteRepository _repository;

  IsFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(IsFavoriteParams params) async {
    return await _repository.isFavorite(params.id);
  }
}

class IsFavoriteParams {
  const IsFavoriteParams(this.id);

  final int id;
}
