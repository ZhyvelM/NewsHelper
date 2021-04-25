import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CacheModel extends NewsModel{

  void loadData() async {
    newsList = await NewsDBWorker.db.getAll();
    getResult();
    if(newsList != null) {
      newsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    print("## CacheModel.loadData() : newsList.length = ${newsList.length}");
    notifyListeners();
  }
}

CacheModel cacheModel = CacheModel();