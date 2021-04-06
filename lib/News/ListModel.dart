import 'package:flutter/material.dart';
import 'package:news_observer/News/News.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsModel extends Model {

  List<News> newsList = [];
  List<News> _resultList = [];
  String searchQuery;
  DateTimeRange dateTimeRange;

  void setChosenDate(DateTimeRange inDateRange){

    print("## NewsModel.setChosenDate() inDateRange = $inDateRange");

    dateTimeRange = inDateRange;
    notifyListeners();
  }

  void setSearchQuery(String inSearchQuery){
    print("## NewsModel.setSearchQuery() inSearchQuery = $inSearchQuery");

    searchQuery = inSearchQuery;
    notifyListeners();
  }

  getResult(){
    _resultList = newsList;
    if(searchQuery.isNotEmpty)
      {
        _resultList = _resultList.where((el) => el.description.contains(searchQuery) || el.title.contains(searchQuery));
      }
    if(dateTimeRange != null)
      {
        _resultList = _resultList.where((el) => dateTimeRange.start.isBefore(el.dateTime) && dateTimeRange.end.isAfter(el.dateTime));
      }
    notifyListeners();
    return _resultList;
  }
}