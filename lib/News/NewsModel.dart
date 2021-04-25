import 'package:flutter/material.dart';
import 'package:news_observer/News/News.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsModel extends Model {
  int stackIndex = 0;
  var newsToView;
  List<News> newsList = [];
  List<News> resultList = [];
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
    resultList = newsList;
    print("## NewsModel.getResult() : resultList = $resultList");
    print("## NewsModel.getResult() : searchQuery = $searchQuery");
    if(searchQuery != null && searchQuery.isNotEmpty)
      {
        resultList = resultList.where((el) => el.description.contains(searchQuery) || el.title.contains(searchQuery));
      }
    print("## NewsModel.getResult() : dateTimeRange = $dateTimeRange");
    if(dateTimeRange != null)
      {
        resultList = resultList.where((el) => dateTimeRange.start.isBefore(el.dateTime) && dateTimeRange.end.isAfter(el.dateTime));
      }
    return resultList;
  }

  void setStackIndex(int inStackIndex){
    print("## NewsModel.setStackIndex() : inStackIndex = $inStackIndex");

    stackIndex = inStackIndex;
    notifyListeners();
  }
}