import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:my_movies_app/features/presentation/widgets/failure.dart';

abstract class MyMoviesRepository {
  Future<Either<Failure, List<MoviesHomeEntity>>> getMoviesList(String cacheKey);
}
