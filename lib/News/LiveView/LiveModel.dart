import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/NewsGetter.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LiveModel extends NewsModel{

  void loadData() async {
    newsList = await NewsGetter.parser.getNews(DateTime.now());
    getResult();
    newsList.forEach((element) async {
        if (await NewsDBWorker.db.isNotExist(element)) {
          NewsDBWorker.db.create(element);
        }
    });
    notifyListeners();
  }

  void loadDataSearchArgs(){
    //TODO

    notifyListeners();
  }
}

LiveModel liveModel = LiveModel();