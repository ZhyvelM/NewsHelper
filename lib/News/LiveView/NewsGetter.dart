import 'package:news_observer/News/LiveView/Parsers/SputnikParser.dart';
import 'package:news_observer/News/News.dart';
import 'package:news_observer/utils.dart' as utils;

import 'Parsers/TutByParser.dart';

class NewsGetter {
  NewsGetter._();
  static final NewsGetter parser = NewsGetter._();

  Future<List<News>> getNews(DateTime day) async {
    print("## NewsGetter.getNews() : day = $day");
    List<News> newsList = [];
    if (utils.prefs.getBool("tutby")) {
      var tutBy = await TutByParser.parser.getNews(day);
      if (tutBy != null) {
        newsList += tutBy;
      }
    }
    if (utils.prefs.getBool("sputnik")) {
      var sputnik = await SputnikParser.parser.getNews(day);
      if (sputnik != null) {
        newsList += sputnik;
      }
    }
    if (newsList != null) {
      newsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    print("## NewsGetter.getNews() : sortedList = $newsList");
    return newsList;
  }
}
