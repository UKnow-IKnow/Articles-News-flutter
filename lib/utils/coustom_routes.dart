import 'package:articles_news/model/news_data.dart';
import 'package:articles_news/ui/error.dart';
import 'package:articles_news/ui/home.dart';
import 'package:articles_news/ui/news_details.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static Route generateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;

    switch (routeSettings.name) {
      case Home.routeName:
        return Home.getNavigator();

      case NewsDetails.routeName:
        if (args is Articles) {
          return NewsDetails.getNavigator(args);
        } else {
          return ErrorScreen.getNavigator();
        }
      default:
        return MaterialPageRoute(builder: (c) => const ErrorScreen());
    }
  }
}
