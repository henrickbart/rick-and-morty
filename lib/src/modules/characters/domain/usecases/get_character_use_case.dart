import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../entities/character.dart';
import '../repositories/i_character_repository.dart';

class GetCharacterUseCase implements IUseCase<Character, GetCharacterParams> {
  final ICharacterRepository characterRepository;

  GetCharacterUseCase({required this.characterRepository});

  @override
  Future<Either<Failure, Character>> call(GetCharacterParams params) async {
    return await characterRepository.getCharacter(id: params.id);
  }
}

class GetCharacterParams extends Equatable {
  const GetCharacterParams({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
