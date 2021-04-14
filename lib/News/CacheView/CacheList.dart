import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../News.dart';
import 'CacheModel.dart' show cacheModel, CacheModel;

class CacheList extends StatelessWidget{
  @override
  Widget build(BuildContext inContext) {
    print("## CacheList.build()");

    return ScopedModel<CacheModel>(
      model: cacheModel,
      child: ScopedModelDescendant<CacheModel>(
        builder: (BuildContext inContext, Widget inChild, CacheModel inModel){
          return Scaffold(
            body: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              itemCount: cacheModel.getResult().length,
              itemBuilder: (BuildContext inBuildContext, int inIndex){
                News news = cacheModel.getResult()[inIndex];
                var month = news.dateTime.month;
                var day = news.dateTime.day;
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.description),
                  trailing: Text("${news.site} at $month.$day"),
                  onTap: () async{
                    cacheModel.newsToView = NewsDBWorker.db.get(news.id);
                    cacheModel.setStackIndex(1);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}