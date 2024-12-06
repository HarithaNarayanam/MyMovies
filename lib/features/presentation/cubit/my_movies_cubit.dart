import 'package:my_movies_app/features/domain/usecases/my_movies_usecases.dart';
import 'package:my_movies_app/features/presentation/cubit/my_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMoviesHomeCubit extends Cubit<MyMoviesHomeState> {
  final MyMoviesUseCases myMoviesUseCases;

  MyMoviesHomeCubit(this.myMoviesUseCases) : super(MyMoviesHomeEmptyState());

  void emitStateWithCloseCheck(state) {
    if (!isClosed) {
      emit(state);
    }
  }

  void getMoviesList(String cacheKey) async {
    try {
      emitStateWithCloseCheck(MyMoviesHomeLoadingState());
      var result = await myMoviesUseCases.getMoviesList(cacheKey);
      result.fold((failure) {
        emitStateWithCloseCheck(const MyMoviesHomeErrorState(msg: "failure"));
      }, (data) {
        emitStateWithCloseCheck(
            MyMoviesHomeLoadedState(myMoviesHomeEntity: data, searchList: data, data: data));
      });
    } catch (e) {
      emitStateWithCloseCheck(MyMoviesHomeErrorState(msg: e.toString()));
    }
  }

  onSearchAllMovies(MyMoviesHomeLoadedState state, String value) {
    emitStateWithCloseCheck(MyMoviesHomeEmptyState());
    state.onSearchAllMovies(value);
    emitStateWithCloseCheck(state);
  }

  onsetFavMovie(MyMoviesHomeLoadedState state, int index) {
    emitStateWithCloseCheck(MyMoviesHomeEmptyState());
    state.setFav(index);
    emitStateWithCloseCheck(state);
  }
}
