import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/NewsGetter.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

import '../News.dart';

class LiveModel extends NewsModel{

  @override
  void loadData() async {
    isLoading = true;
    if(date == null) date = DateTime.now();
    newsList = await NewsGetter.parser.getNews(date);
    print("## LiveModel.loadData(): date = $date");
    print("## LiveModel.loadData(): newsList.length = ${newsList.length}");
    getResult();
    isLoading = false;
    notifyListeners();
  }

  void loadToDb(News inNews){
    NewsDBWorker.db.create(inNews);
  }
}

LiveModel liveModel = LiveModel();