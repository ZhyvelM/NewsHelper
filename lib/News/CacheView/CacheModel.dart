import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CacheModel extends NewsModel{

  void loadData() async {
    print("## CacheModel.loadData() : newsList.length = ${newsList.length}");
    if(newsList == null || newsList.length == 0) {
      newsList = await NewsDBWorker.db.getAll();
      if (newsList != null) {
        newsList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
    }
    getResult();
    notifyListeners();
  }
}

CacheModel cacheModel = CacheModel();