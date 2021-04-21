import 'package:flutter/material.dart';
import 'package:news_observer/News/News.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsModel extends Model {
  int stackIndex = 0;
  var newsToView;
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

  List<News> getResult(){
    _resultList = newsList;
    print("## NewsModel.getResult() : resultList = $_resultList");
    print("## NewsModel.getResult() : searchQuery = $searchQuery");
    if(searchQuery != null && searchQuery.isNotEmpty)
      {
        _resultList = _resultList.where((el) => el.description.contains(searchQuery) || el.title.contains(searchQuery));
      }
    print("## NewsModel.getResult() : dateTimeRange = $dateTimeRange");
    if(dateTimeRange != null)
      {
        _resultList = _resultList.where((el) => dateTimeRange.start.isBefore(el.dateTime) && dateTimeRange.end.isAfter(el.dateTime));
      }
    return _resultList;
  }

  void setStackIndex(int inStackIndex){
    print("## NewsModel.setStackIndex() : inStackIndex = $inStackIndex");

    stackIndex = inStackIndex;
    notifyListeners();
  }
}