import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_movies_app/features/data/models/home_screen_model.dart';
import 'package:my_movies_app/features/domain/entities/home_screen_entity.dart';
import 'package:my_movies_app/features/presentation/widgets/movies_popscope_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MoviesHomeEntity? data;
  int index = 0;

  @override
  void initState() {
    if (Modular.args.data != null) {
      data = Modular.args.data['data'] ?? "";
      index = Modular.args.data['index'] ?? 0;
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return MoviesPopScope(
      onPopInvoked: () {
        Modular.to.pop({"isStar": data!.isFav, "index": index});
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,

          leading: InkWell(
            onTap: () => Modular.to.pop({"isStar": data!.isFav, "index": index}),
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
          // automaticallyImplyLeading: true,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Text("My Movie - Detailed View"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data!.id.toString(),
                      style: const TextStyle(
                          fontSize: 25, color: Colors.black // Set the font size here
                          ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CachedNetworkImage(
                      imageUrl: data!.posterUrl.isNotEmpty ? data!.posterUrl : "",
                      placeholder: (context, url) => Icon(Icons.error),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data!.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.black // Set the font size here
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "IMDB : ${data!.imdbId}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black // Set the font size here
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        data!.isFav = !data!.isFav;
                        // isStar = !isStar;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        data!.isFav ? 'assets/heart_fill.svg' : "assets/heart_stroke.svg",
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
