import 'dart:io';

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
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
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
        print("## NewsGetter.getNews() : sortedList = $newsList");
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    if (newsList != null) {
      newsList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }
    return newsList;
  }
}
