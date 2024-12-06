import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';

List<MoviesHomeModel> myMoviesFromJson(String str) =>
    List<MoviesHomeModel>.from(json.decode(str).map((x) => MoviesHomeModel.fromJson(x)));
String moviesHomeModelToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesHomeModel extends MoviesHomeEntity {
  MoviesHomeModel({
    required id,
    required title,
    required posterUrl,
    required imdbId,
  }) : super(id: id, title: title, posterUrl: posterUrl, imdbId: imdbId);

  factory MoviesHomeModel.fromJson(Map<String, dynamic> json) => MoviesHomeModel(
        id: (json["id"] ?? "").toString(),
        title: json["title"] ?? "",
        posterUrl: json["posterURL"] ?? "",
        imdbId: json["imdbId"] ?? "",
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "posterURL": posterUrl,
        "imdbId": imdbId,
      };
}

class MoviesHomeModelAdapter extends TypeAdapter<MoviesHomeModel> {
  @override
  final int typeId = 1; // Must match the typeId in @HiveType

  @override
  MoviesHomeModel read(BinaryReader reader) {
    return MoviesHomeModel(
      id: reader.read(),
      title: reader.read(),
      posterUrl: reader.read(),
      imdbId: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, MoviesHomeModel obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.posterUrl);
    writer.write(obj.imdbId);
  }
}
