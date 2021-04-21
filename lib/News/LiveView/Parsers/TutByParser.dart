import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/Parsers/IParserInterface.dart';
import 'package:news_observer/News/News.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser1;
import 'package:html/dom.dart' as dom;

class TutByParser implements IParserInterface{

  TutByParser._();

  static final TutByParser parser = TutByParser._();

  @override
  Future<List<News>> getNews(DateTime day) async{
    print("## TutByParser.getNews() : day = $day");
    List<News> newsList = [];
    final _authority = "news.tut.by";
    final _path = "/archive/${day.day}.${day.month}.${day.year}.html";
    final _params = { "sort" : "time#sort" };
    String path = 'https://news.tut.by/archive/${day.day}.${day.month}.${day.year}.html?sort=time#sort';
    print("## TutByParser.getNews() : path = $path");
    final response = await http.get(Uri.https(_authority,_path,_params));
    print("## TutByParser.getNews() : response = $response");
    dom.Document document = parser1.parse(response.body);
    final news = document.getElementsByClassName("entry__link");
    print("## TutByParser.getNews() : news elements = ${news.length}");
    news.forEach((element) {
      News news = News();
      //print("## TutByParser.getNews() : element = ${element.innerHtml}");
      if(element.getElementsByClassName("_title").isNotEmpty &&
          element.getElementsByClassName("entry-time").isNotEmpty){
        news.title = element.getElementsByClassName("_title")[0].text;
        news.description = "";
        news.site = "TUT.BY";
        news.link = element.attributes["href"];
        String date = element.getElementsByClassName("entry-time")[0].getElementsByTagName("span")[0].text;
        news.dateTime = DateTime(day.year, day.month, day.day, int.parse(date.split(" ").last.split(":").first), int.parse(date.split(" ").last.split(":").last));
        print("## TutByParser.getNews() : news = $news");
        newsList.add(news);
      }
    });
    print("## TutByParser.getNews() : newsList = $newsList");
    return newsList;
  }

  @override
  Future<List<News>> getNewsByRange(DateTimeRange dayRange) async{
    List<News> newsList;
    for(var i =0; i < dayRange.end.difference(dayRange.start).inDays; i++){
      newsList += await getNews(dayRange.start.add(Duration(days: i)));
    }
    return newsList;
  }
}