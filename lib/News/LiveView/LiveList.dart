import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../News.dart';
import 'LiveModel.dart' show liveModel, LiveModel;

class LiveList extends StatelessWidget {
  @override
  Widget build(BuildContext inContext) {
    print("## LiveList.build()");
    print("## LiveList news list = ${liveModel.newsList}");
    return ScopedModel<LiveModel>(
      model: liveModel,
      child: ScopedModelDescendant<LiveModel>(
        builder: (BuildContext inContext, Widget inChild, LiveModel inModel) {
          return Scaffold(
              body: (liveModel.newsList != null) ? ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                itemCount: liveModel
                    .getResult()
                    .length,
                itemBuilder: (BuildContext inBuildContext, int inIndex) {
                  News news = liveModel.getResult()[inIndex];
                  var month = news.dateTime.month;
                  var day = news.dateTime.day;
                  var hour = news.dateTime.hour;
                  var minute = news.dateTime.minute;
                  return Column(
                      children: [
                        ListTile(
                          title: SizedBox.fromSize(
                            child: Text(news.title, textScaleFactor: 1,),
                          ),
                          subtitle: SizedBox.fromSize(
                            child: Text(news.description, textScaleFactor: 0.8,),
                          ),
                          trailing: SizedBox.fromSize(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${news.site}", textScaleFactor: 1,),
                                Text("$month.$day at $hour:$minute", textScaleFactor: 0.8,),
                              ],
                            ),
                            size: Size(90, 60),),
                          onTap: () async {
                            liveModel.newsToView = news;
                            liveModel.setStackIndex(1);
                          },
                        ),
                        Divider()
                      ]
                  );
                },
              ) :
              Center(
                child:
                ElevatedButton(
                    onPressed: () {
                      liveModel.loadData();
                    },
                    child: Text("Load news")
                ),
              )
          );
        },
      ),
    );
  }
}