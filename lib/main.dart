import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_movies_app/features/data/models/home_screen_model.dart';
import 'package:my_movies_app/features/presentation/pages/my_movies_home_screen.dart';
import 'package:my_movies_app/my_movies_routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MoviesHomeModelAdapter());
  // if (!Hive.isBoxOpen('movies_cache')) {
  //   await Hive.openBox<List<MoviesHomeModel>>('movies_cache');
  // }
  // await Hive.openBox('movies_cache');
  runApp(ModularApp(module: MyMoviesRouting(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Movies',
      // color: const SplashScreen(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
