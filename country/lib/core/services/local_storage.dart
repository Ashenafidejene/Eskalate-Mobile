import 'package:shared_preferences/shared_preferences.dart';
import '../errors/exceptions.dart';

abstract class LocalStorage {
  Future<void> saveData(String key, String value);
  Future<String?> getData(String key);
  Future<void> removeData(String key);
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorageImpl(this.sharedPreferences);

  @override
  Future<void> saveData(String key, String value) async {
    try {
      await sharedPreferences.setString(key, value);
    } on Exception {
      throw CacheException('Could not save data');
    }
  }

  @override
  Future<String?> getData(String key) async {
    try {
      return sharedPreferences.getString(key);
    } on Exception {
      throw CacheException('Could not retrieve data');
    }
  }

  @override
  Future<void> removeData(String key) async {
    try {
      await sharedPreferences.remove(key);
    } on Exception {
      throw CacheException('Could not remove data');
    }
  }
}
