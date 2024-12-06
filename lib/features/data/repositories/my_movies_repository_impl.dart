import 'package:dartz/dartz.dart';
import 'package:my_movies_app/features/data/datasources/my_movies_data_source.dart';
import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';
import 'package:my_movies_app/features/domain/repositories/my_movies_repository.dart';
import 'package:my_movies_app/features/presentation/widgets/failure.dart';

class MyMoviesRepositoryImpl extends MyMoviesRepository {
  final MyMoviesDataSource myMoviesDataSource;

  MyMoviesRepositoryImpl({required this.myMoviesDataSource});

  @override
  Future<Either<Failure, List<MoviesHomeEntity>>> getMoviesList(String cacheKey) async {
    try {
      final result = await myMoviesDataSource.getMoviesList(cacheKey);
      if (result is List<MoviesHomeEntity>) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
