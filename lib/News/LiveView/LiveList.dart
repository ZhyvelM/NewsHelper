import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../News.dart';
import 'LiveModel.dart' show liveModel, LiveModel;

class LiveList extends StatelessWidget{
  @override
  Widget build(BuildContext inContext) {
    print("## LiveList.build()");

    return ScopedModel<LiveModel>(
      model: liveModel,
      child: ScopedModelDescendant<LiveModel>(
        builder: (BuildContext inContext, Widget inChild, LiveModel inModel){
          return Scaffold(
            body: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              itemCount: liveModel.getResult().length,
              itemBuilder: (BuildContext inBuildContext, int inIndex){
                News news = liveModel.getResult()[inIndex];
                var month = news.dateTime.month;
                var day = news.dateTime.day;
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.description),
                  trailing: Text("${news.site} at $month.$day"),
                  onTap: () async{
                    liveModel.newsToView = NewsDBWorker.db.get(news.id);
                    liveModel.setStackIndex(1);
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