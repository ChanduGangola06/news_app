import 'package:hive/hive.dart';
import 'package:news_app/Models/news_data_model.dart';

class HiveService {
  static const String hiveBoxName = 'news_box';
  List<News> _newsList = [];
  // late Box<List<News>> _newsList;

  void getDataFromHive() async {
    final box = await Hive.openBox<News>(hiveBoxName);
    _newsList = box.values.toList();
  }

  void addDataToHive(List<News> newsList) async {
    final box = await Hive.openBox<News>(hiveBoxName);
    for (var news in newsList) {
      await box.add(news);
    }
    _newsList = box.values.toList();
  }

  List<News> get getNews => _newsList;
  int get newsCount => _newsList.length;
}
