import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_movies_app/features/data/models/home_screen_model.dart';
import 'package:my_movies_app/features/presentation/widgets/hive_db_utilities.dart';

abstract class MyMoviesDataSource {
  Future<dynamic> getMoviesList(String cacheKey);
}

class MyMoviesDataSourceImpl extends MyMoviesDataSource {
  MyMoviesDataSourceImpl();

  @override
  Future<dynamic> getMoviesList(String cacheKey) async {
    debugPrint('isConnected : ${await OfflineCache.isConnected()}');
    if (await OfflineCache.isConnected()) {
      try {
        final url = Uri.parse('https://api.sampleapis.com/movies/animation');
        dynamic response = await http.get(url);
        if (response.toString().isNotEmpty) {
          final res = myMoviesFromJson(response.body);
          await OfflineCache.cacheData(cacheKey, response.body);
          return res;
        } else {
          throw Exception("Failed to fetch data from server");
        }
      } catch (e) {
        debugPrint('exception : -${e.toString()}');
        throw Exception("Error while fetching data: $e");
      }
    } else {
      debugPrint('getCachedData : -- ${OfflineCache.getCachedData(cacheKey)}');
      final data = await OfflineCache.getCachedData(cacheKey);
      debugPrint('data : ${data}');
      return data;
    }
  }
}
