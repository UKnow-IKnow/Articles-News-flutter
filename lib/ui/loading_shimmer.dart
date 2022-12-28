import 'package:articles_news/ui/news.dart';
import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key}) : super(key: key);
  static const String routeName = '/LoadingShimmer';

  static getNavigator() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: "/LoadingShimmer"),
        builder: (c) {
          return const LoadingShimmer();
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return newsCardShimmer(context);
      },
    );
  }
}
