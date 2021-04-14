import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LiveModel extends NewsModel{

  void loadData() async {

    notifyListeners();
  }
}

LiveModel liveModel = LiveModel();