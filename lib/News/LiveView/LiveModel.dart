import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/NewsGetter.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LiveModel extends NewsModel{

  @override
  void loadData() async {
    isLoading = true;
    newsList = await NewsGetter.parser.getNews(date);
    print("## LiveModel.loadData(): date = $date");
    print("## LiveModel.loadData(): newsList.length = ${newsList.length}");
    getResult();
    Future(()=>{loadToDb()});
    isLoading = false;
    notifyListeners();
  }

  void loadToDb(){
    newsList.forEach((element) async {
      if (await NewsDBWorker.db.isNotExist(element)) {
        NewsDBWorker.db.create(element);
      }
    });
  }
}

LiveModel liveModel = LiveModel();