import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_movies_app/features/data/repositories/my_movies_repository_impl.dart';
import 'package:my_movies_app/features/presentation/cubit/my_movies_cubit.dart';
import 'package:my_movies_app/features/presentation/pages/my_movies_details_screen.dart';
import 'package:my_movies_app/features/presentation/pages/my_movies_favourites_screen.dart';
import 'package:my_movies_app/features/presentation/pages/my_movies_home_screen.dart';
import 'package:my_movies_app/features/presentation/pages/my_movies_splash_screen.dart';

import 'features/data/datasources/my_movies_data_source.dart';
import 'features/domain/usecases/my_movies_usecases.dart';

class MyMoviesRouting extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const SplashScreen(),
            transition: TransitionType.noTransition),
        ChildRoute("/HomeScreen", child: (context, args) {
          return BlocProvider<MyMoviesHomeCubit>(
              create: (context) => MyMoviesHomeCubit(MyMoviesUseCases(
                  MyMoviesRepositoryImpl(myMoviesDataSource: MyMoviesDataSourceImpl()))),
              child: const HomeScreen());
        }, transition: TransitionType.noTransition),
        ChildRoute('/DetailsScreen',
            child: (context, args) => const DetailsScreen(),
            transition: TransitionType.noTransition),
        ChildRoute('/FavScreen',
            child: (context, args) => const FavouritesScreen(),
            transition: TransitionType.noTransition),
      ];
}
