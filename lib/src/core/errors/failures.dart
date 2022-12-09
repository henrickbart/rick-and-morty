import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

extension FailureExtension on Failure {
  String get message {
    switch (runtimeType) {
      case ServerFailure:
        return 'Server failure. Please try again later.';
      case NotFoundFailure:
        return 'No results found for your search.';
      case CacheFailure:
        return 'Failure trying to access local repository.';
      default:
        return 'Unexpected Error';
    }
  }
}
