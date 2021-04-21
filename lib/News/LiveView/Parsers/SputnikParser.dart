import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/Parsers/IParserInterface.dart';
import 'package:news_observer/News/News.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser1;
import 'package:html/dom.dart' as dom;

class SputnikParser extends IParserInterface{

  SputnikParser._();

  static final SputnikParser parser = SputnikParser._();

  @override
  Future<List<News>> getNews(DateTime day) async{
    print("## SputnikParser.getNews() : day = $day");
    List<News> newsList = [];
    final _authority = "sputnik.by";
    final _path = "/news/${day.year}${day.month}${day.day}/";
    String path = 'https://sputnik.by/news/${day.year}${day.month}${day.day}/';
    print("## SputnikParser.getNews() : path = $path");
    final response = await http.get(Uri.https(_authority,_path));
    print("## SputnikParser.getNews() : response = $response");
    dom.Document document = parser1.parse(response.body);
    final news = document.getElementsByClassName("b-plainlist__info");
    print("## SputnikParser.getNews() : news elements = ${news.length}");
    news.forEach((element) {
      News news = News();
      //print("## SputnikParser.getNews() : element = ${element.innerHtml}");
      if(element.getElementsByClassName("b-plainlist__title").isNotEmpty &&
          element.getElementsByClassName("b-plainlist__announce").isNotEmpty && element.getElementsByClassName("b-plainlist__date").isNotEmpty){
        news.title = element.getElementsByClassName("b-plainlist__title")[0].getElementsByTagName("a")[0].text;
        news.description = element.getElementsByClassName("b-plainlist__announce")[0].getElementsByTagName("p")[0].text;
        news.site = "SPUTNIK.BY";
        news.link = element.getElementsByClassName("b-plainlist__title")[0].getElementsByTagName("a")[0].attributes["href"];
        String date = element.getElementsByClassName("b-plainlist__date")[0].text;
        news.dateTime = DateTime(day.year, day.month, day.day, int.parse(date.split(" ").first.split(":").first), int.parse(date.split(" ").first.split(":").last));
        print("## SputnikParser.getNews() : news = $news");
        newsList.add(news);
      }
    });
    print("## SputnikParser.getNews() : newsList = $newsList");
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