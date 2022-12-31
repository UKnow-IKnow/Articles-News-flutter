import 'dart:convert';

import 'package:articles_news/controller/home_cubit.dart';
import 'package:articles_news/model/home_state.dart';
import 'package:articles_news/utils/c_data.dart';
import 'package:articles_news/utils/common_function.dart';
import 'package:articles_news/utils/constants.dart';
import 'package:articles_news/ui/news.dart';
import 'package:articles_news/ui/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = '/Home';

  static getNavigator() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: "/Home"),
        builder: (c) {
          return const Home();
        });
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    loadCategory();

    context.read<HomeCubit>().getNews(context);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await context.read<HomeCubit>().getNextPageNews();
      }
    });
  }

  loadCategory() async {
    final categoryJson =
        await rootBundle.loadString("assets/files/category.JSON");
    final decodeData = jsonDecode(categoryJson);
    var categoryData = decodeData["categories"];
  }

  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();

        return false;
      },
      child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: black,
            title: Text(
              "ArticlesNews",
              style: GoogleFonts.getFont("Roboto Slab",
                  letterSpacing: 4,
                  fontSize: 29,
                  color: white,
                  fontWeight: FontWeight.bold),
            ),
            leading: Container(),
            centerTitle: true,
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == STATUS.loading) {
                return const LoadingShimmer();
              } else if (state.status == STATUS.success) {
                return RefreshIndicator(
                  color: black,
                  onRefresh: () {
                    return context.read<HomeCubit>().getNews(context);
                  },
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: scrollController,
                    itemCount: state.newsData.articles!.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index <= state.newsData.articles!.length - 1) {
                        return NewsCard(
                            context, state.newsData.articles![index]);
                      } else {
                        return state.status2 == STATUS.loading
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        "assets/loading.gif",
                                        height: 125.0,
                                        width: 125.0,
                                      )),
                                ))
                            : Container();
                      }
                    },
                  ),
                );
              } else if (state.status == STATUS.no_data) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                      child: myText(
                    "no cached data found, \nconnect to internet\nand try again",
                  )),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                      child: myText(
                    "Something went wrong, \nplease try again later",
                  )),
                );
              }
            },
          )),
    );
  }
}
