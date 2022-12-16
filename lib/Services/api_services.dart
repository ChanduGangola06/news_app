// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0b04a80d10b64ed0911e46a700940eb5

import 'package:dio/dio.dart';

import 'package:news_app/Models/news_data_model.dart';
import 'package:news_app/constants/key.dart';

class NewsRepository {
  Future<List<News>> getNews() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$ApiKey',
      );
      late final List<News> articleList;
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> decodedData = (response.data);
        List articlesList = decodedData['articles'];
        List<News> newsList =
            articlesList.map((article) => News.fromJson(article)).toList();

        articleList = newsList;
      }
      return articleList;
    } catch (e) {
      rethrow;
    }
  }
}
