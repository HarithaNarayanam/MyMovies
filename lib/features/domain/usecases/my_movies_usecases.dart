import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';
import 'package:my_movies_app/features/domain/repositories/my_movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:my_movies_app/features/presentation/widgets/failure.dart';

class MyMoviesUseCases {
  final MyMoviesRepository myMoviesRepository;

  MyMoviesUseCases(this.myMoviesRepository);

  Future<Either<Failure, List<MoviesHomeEntity>>> getMoviesList(String cacheKey) {
    return myMoviesRepository.getMoviesList(cacheKey);
  }
}
