import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IFavoriteDataSource {
  Future<List<CharacterModel>> getFavorites();
  Future<bool> isFavorite({required int id});
  Future<bool> addFavorite({required CharacterModel character});
  Future<bool> removeFavorite({required int id});
}

class FavoriteDataSource implements IFavoriteDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteDataSource({required this.sharedPreferences});

  @override
  Future<bool> addFavorite({required CharacterModel character}) {
    try {
      return sharedPreferences.setString(character.id.toString(), character.toJson().toString());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<CharacterModel>> getFavorites() {
    try {
      return Future.value(sharedPreferences.getKeys().map((key) => CharacterModel.fromJson(sharedPreferences.getString(key) ?? '', rootOrigin: true, rootLocation: true)).toList());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isFavorite({required int id}) {
    try {
      return Future.value(sharedPreferences.containsKey(id.toString()));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> removeFavorite({required int id}) {
    try {
      return sharedPreferences.remove(id.toString());
    } catch (e) {
      throw CacheException();
    }
  }
}
