import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:articles_news/controller/api_service.dart';
import 'package:articles_news/controller/hive_db.dart';
import 'package:articles_news/model/home_state.dart';
import 'package:articles_news/model/news_data.dart';
import 'package:articles_news/utils/common_function.dart';
import 'package:articles_news/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  getNews(BuildContext context) async {
    try {
      emit(state.copyWith(status: STATUS.loading));

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        await getDataFromDb();
        getToast(context, "No Network");
        return;
      }

      var result = await ApiService.getNews(1);
      if (result is NewsData) {
        await AppHiveDb.clearData();
        await AppHiveDb.setData(jsonEncode(result.toJson()));
        emit(state.copyWith(status: STATUS.success, page: 1, newsData: result));
        log(state.newsData.toString());
      } else if (result is String) {
        emit(state.copyWith(status: STATUS.error, error: result));
      }
    } catch (e) {
      emit(state.copyWith(status: STATUS.error, error: e.toString()));
    }
  }

  getNextPageNews() async {
    if (state.status2 != STATUS.loading) {
      emit(state.copyWith(status2: STATUS.loading));

      try {
        var result = await ApiService.getNews(state.page + 1);
        if (result is NewsData) {
          var data = state.newsData.articles;

          for (var i = 0; i < result.articles!.length; i++) {
            data!.add(result.articles![i]);
          }
          state.newsData.articles = data;
          emit(state.copyWith(
              status2: STATUS.success,
              page: result.articles!.isEmpty ? state.page : state.page + 1,
              newsData: state.newsData));
        } else if (result is String) {
          emit(state.copyWith(
            status2: STATUS.error,
          ));
        }
      } catch (e) {}
    }
  }

  getDataFromDb() async {
    try {
      var result = await AppHiveDb.getAllData();
      if (result.toString() == "[]") {
        emit(state.copyWith(status: STATUS.no_data));
        return;
      }
      NewsData newsData = NewsData.fromJson(jsonDecode(result[0].toString()));
      emit(state.copyWith(status: STATUS.success, newsData: newsData));
    } catch (e) {
      emit(state.copyWith(status: STATUS.error, error: e.toString()));
    }
  }
}
