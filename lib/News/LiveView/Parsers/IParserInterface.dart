import 'package:flutter/material.dart';
import 'package:news_observer/News/News.dart';

abstract class IParserInterface {
  Future<List<News>> getNews(DateTime day);
  Future<List<News>> getNewsByRange(DateTimeRange dayRange);
}