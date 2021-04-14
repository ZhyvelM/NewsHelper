import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CacheModel extends NewsModel{

  void loadData() async {

    newsList = await NewsDBWorker.db.getAll();
    notifyListeners();
  }
}

CacheModel cacheModel = CacheModel();