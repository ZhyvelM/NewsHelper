import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CacheModel extends NewsModel{

  Future<void> loadData() async {
    print("## CacheModel.loadData() : newsList.length = ${newsList.length}");
    isLoading = true;
      newsList = await NewsDBWorker.db.getAll();
      if (newsList != null) {
        newsList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
    getResult();
    isLoading = false;
    notifyListeners();
  }

  void deleteNews(int inID) async{
    isLoading = true;
    NewsDBWorker.db.delete(inID);
    newsList = await NewsDBWorker.db.getAll();
    loadData();
  }
}

CacheModel cacheModel = CacheModel();