import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_movies_app/features/data/models/home_screen_model.dart';
import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<MoviesHomeEntity>? data;

  void initState() {
    if (Modular.args.data != null && Modular.args.data.isNotEmpty) {
      data = Modular.args.data['data'] ?? <MoviesHomeEntity>[];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: () => Modular.to.pop(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/back_arrow.png',
                // Path to the image in your assets
                fit: BoxFit.fitWidth, // Optional: Adjust how the image fits its container
              ),
            ),
          ),
          leadingWidth: 40,
          titleSpacing: 0,
          title: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("My Movie - Fav movies"),
          ),
        ),
        body: (data != null && data!.isEmpty)
            ? const SizedBox.shrink()
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: data!.length,
                itemBuilder: (BuildContext context, index1) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data![index1].id.toString(),
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.black // Set the font size here
                                    ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              CachedNetworkImage(
                                imageUrl: data![index1].posterUrl.isNotEmpty
                                    ? data![index1].posterUrl
                                    : "",
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data![index1].title,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.black // Set the font size here
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "IMDB : ${data![index1].imdbId}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black // Set the font size here
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  data![index1].isFav = !data![index1].isFav;
                                  data!.removeWhere((rw) => rw.isFav == data![index1].isFav);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
