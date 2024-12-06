import 'package:equatable/equatable.dart';

class MoviesHomeEntity extends Equatable {
  final String id;
  final String title;
  final String posterUrl;
  final String imdbId;
  bool isFav;

  MoviesHomeEntity({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.imdbId,
    this.isFav = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        posterUrl,
        imdbId,
      ];
}
