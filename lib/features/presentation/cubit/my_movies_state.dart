import 'package:equatable/equatable.dart';
import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';

class MyMoviesHomeState extends Equatable {
  const MyMoviesHomeState();

  @override
  List<Object?> get props => [];
}

class MyMoviesHomeEmptyState extends MyMoviesHomeState {
  @override
  List<Object> get props => [];
}

class MyMoviesHomeLoadingState extends MyMoviesHomeState {
  @override
  List<Object> get props => [];
}

class MyMoviesHomeLoadedState extends MyMoviesHomeState {
  final List<MoviesHomeEntity> myMoviesHomeEntity;
  List<MoviesHomeEntity> data;

  List<MoviesHomeEntity> searchList = [];
  List<MoviesHomeEntity> favList = [];

  MyMoviesHomeLoadedState(
      {required this.myMoviesHomeEntity, required this.searchList, required this.data});

  onSearchAllMovies(String v) {
    if (v.isNotEmpty) {
      searchList = [];
      searchList.addAll(data
          .where((element) =>
              element.title != null && element.title!.toLowerCase().contains(v.toLowerCase()))
          .toList());
    } else {
      searchList = data;
    }
  }

  setFav(int index) {
    myMoviesHomeEntity[index].isFav = !myMoviesHomeEntity[index].isFav;
  }
}

class MyMoviesHomeErrorState extends MyMoviesHomeState {
  final String msg;

  const MyMoviesHomeErrorState({required this.msg});
}
