import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String airDate;
  final String episode;

  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, name, airDate, episode];
  }
}
