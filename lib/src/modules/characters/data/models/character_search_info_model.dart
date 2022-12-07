import 'dart:convert';

import 'package:equatable/equatable.dart';

class CharacterSearchInfoModel extends Equatable {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const CharacterSearchInfoModel(
      {required this.count, required this.pages, this.next, this.prev});

  factory CharacterSearchInfoModel.fromMap(Map<String, dynamic> data) =>
      CharacterSearchInfoModel(
        count: data['count'] as int,
        pages: data['pages'] as int,
        next: data['next'] as String?,
        prev: data['prev'] as String?,
      );

  factory CharacterSearchInfoModel.fromJson(String data) {
    return CharacterSearchInfoModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [count, pages, next, prev];
}
