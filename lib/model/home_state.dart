import 'package:articles_news/model/news_data.dart';
import 'package:articles_news/utils/constants.dart';

class HomeState {
  NewsData newsData;
  int page;
  STATUS status;
  STATUS status2;
  String error;
  bool isConnected;
  HomeState({
    required this.newsData,
    required this.page,
    required this.status,
    required this.status2,
    required this.error,
    required this.isConnected,
  });

  factory HomeState.initial() {
    return HomeState(
      status2: STATUS.initial,
      newsData: NewsData.initial(),
      page: 0,
      status: STATUS.initial,
      error: "",
      isConnected: false,
    );
  }

  HomeState copyWith({
    NewsData? newsData,
    int? page,
    STATUS? status,
    STATUS? status2,
    String? error,
    bool? isConnected,
  }) {
    return HomeState(
      newsData: newsData ?? this.newsData,
      page: page ?? this.page,
      status: status ?? this.status,
      status2: status2 ?? this.status2,
      error: error ?? this.error,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
