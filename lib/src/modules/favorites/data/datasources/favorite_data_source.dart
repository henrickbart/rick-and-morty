import 'package:rick_and_morty/src/core/errors/exceptions.dart';
import 'package:rick_and_morty/src/modules/characters/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IFavoriteDataSource {
  Future<List<CharacterModel>> getFavorites();
  Future<bool> isFavorite(int id);
  Future<bool> addFavorite(CharacterModel character);
  Future<bool> removeFavorite(int id);
}

class FavoriteDataSource implements IFavoriteDataSource {
  final SharedPreferences _sharedPreferences;

  FavoriteDataSource(this._sharedPreferences);

  @override
  Future<bool> addFavorite(CharacterModel character) {
    try {
      return _sharedPreferences.setString(character.id.toString(), character.toJson().toString());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<CharacterModel>> getFavorites() {
    try {
      return Future.value(_sharedPreferences.getKeys().map((key) => CharacterModel.fromJson(_sharedPreferences.getString(key) ?? '', rootOrigin: true, rootLocation: true)).toList());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isFavorite(int id) {
    try {
      return Future.value(_sharedPreferences.containsKey(id.toString()));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> removeFavorite(int id) {
    try {
      return _sharedPreferences.remove(id.toString());
    } catch (e) {
      throw CacheException();
    }
  }
}
