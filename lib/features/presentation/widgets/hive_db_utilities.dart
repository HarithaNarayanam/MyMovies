import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:hive/hive.dart';
import 'package:my_movies_app/features/data/models/home_screen_model.dart';

class OfflineCache {
  static Future<bool> isConnected() async {
    Future<bool> isConnection = Future.value(true);
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      isConnection = Future.value(!connectivityResult.contains(ConnectivityResult.none));
    }
    return isConnection;
  }

  static Future<void> openBox() async {
    await Hive.openBox('movies_cache');
  }

  static Future<void> cacheData(String key, dynamic data) async {
    await openBox();

    var box = Hive.box('movies_cache');

    await box.put(key, data);
  }

  static Future<List<MoviesHomeModel>> getCachedData(String key) async {
    try {
      await openBox();
      var box = Hive.box('movies_cache');
      final data = box.get(key) ?? [];
      final res = myMoviesFromJson(data);
      return res;
    } catch (ex) {
      return [];
    }
  }
}
