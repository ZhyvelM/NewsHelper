import 'package:news_observer/News/LiveView/Parsers/SputnikParser.dart';

import 'Parsers/IParserInterface.dart';
import 'Parsers/TutByParser.dart';
import 'package:flutter/material.dart';
import 'package:news_observer/News/News.dart';

class NewsGetter{

  NewsGetter._();
  static final NewsGetter parser = NewsGetter._();

  Future<List<News>> getNews(DateTime day) async{
    print("## NewsGetter.getNews() : day = $day");
    List<News> newsList = [];
    var tutBy = await TutByParser.parser.getNews(day);
    var sputnik = await SputnikParser.parser.getNews(day);
    if(tutBy != null){
      newsList += tutBy;
    }
    if(sputnik != null){
      newsList += sputnik;
    }
    if(newsList != null) {
      newsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    print("## NewsGetter.getNews() : sortedList = $newsList");
    return newsList;
  }
}