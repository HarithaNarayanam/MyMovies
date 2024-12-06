import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_movies_app/features/presentation/cubit/my_movies_cubit.dart';
import 'package:my_movies_app/features/presentation/cubit/my_movies_state.dart';
import 'package:my_movies_app/features/presentation/widgets/highlight_text.dart';
import 'package:my_movies_app/features/presentation/widgets/movies_popscope_widget.dart';

import 'package:my_movies_app/features/presentation/widgets/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    BlocProvider.of<MyMoviesHomeCubit>(context).getMoviesList('MyMovies');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MoviesPopScope(
      onPopInvoked: () {},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<MyMoviesHomeCubit, MyMoviesHomeState>(
          listener: (context, state) {},
          buildWhen: (previous, current) => current is MyMoviesHomeLoadedState,
          builder: (context, state) {
            if (state is MyMoviesHomeLoadedState) {
              var item = state.searchList;
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            "My Movies",
                            style: TextStyle(
                                fontSize: 24, color: Colors.black // Set the font size here
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 8.0, 22.0, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                contextMenuBuilder: null,
                                autofocus: false,
                                cursorColor: Colors.black,
                                focusNode: searchFocus,
                                controller: searchController,
                                textCapitalization: TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[A-Za-z0-9]"),
                                  ),
                                ],
                                onChanged: (v) {
                                  BlocProvider.of<MyMoviesHomeCubit>(context)
                                      .onSearchAllMovies(state, v);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (state.favList.isNotEmpty) {
                                  Modular.to
                                      .pushNamed("/FavScreen", arguments: {"data": state.favList});
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SvgPicture.asset(
                                  'assets/heart_fill.svg',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  searchController.clear();
                                  state.searchList = state.data;
                                });
                              },
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: SvgPicture.asset('assets/close.svg'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 2.0,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: item.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      searchFocus.unfocus();

                                      Modular.to.pushNamed("/DetailsScreen",
                                          arguments: {"data": item[i], "index": i}).then((value) {
                                        dynamic v = value;

                                        if (v != null &&
                                            v["isStar"] != null &&
                                            v["index"] != null) {
                                          item[v["index"]].isFav = v["isStar"] ?? "";
                                          if (v["isStar"]) {
                                            state.favList.add(item[v["index"]]);
                                          } else {
                                            state.favList.removeWhere((e) => e == item[v["index"]]);
                                          }
                                        }
                                      });

                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(16, i == 0 ? 16 : 0, 16, 16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(item[i].id.toString()),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      HighlightText(
                                                        term: searchController.text,
                                                        text: item[i].title,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 2.0),
                                            child: CachedNetworkImage(
                                                imageUrl: item[i].posterUrl.isNotEmpty
                                                    ? item[i].posterUrl
                                                    : "",
                                                placeholder: (context, url) => Icon(Icons.error),
                                                errorWidget: (context, url, error) =>
                                                    Icon(Icons.error),
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 2.0),
                                            child: SizedBox(
                                              width: 32,
                                              height: 32,
                                              child: SvgPicture.asset('assets/right_stroke.svg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (i != item.length - 1)
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 16.0),
                                      child: Divider(
                                        height: 1,
                                        indent: 16,
                                        endIndent: 16,
                                        color: Colors.blueGrey,
                                        thickness: 1,
                                      ),
                                    ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is MyMoviesHomeLoadingState) {
              return const ShimmerLoad();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
