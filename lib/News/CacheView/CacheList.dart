import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../News.dart';
import '../NewsSearchDelegate.dart';
import 'CacheModel.dart' show cacheModel, CacheModel;

class CacheList extends StatelessWidget {
  @override
  Widget build(BuildContext inContext) {
    print("## CacheList.build()");

    return ScopedModel<CacheModel>(
      model: cacheModel,
      child: ScopedModelDescendant<CacheModel>(
        builder: (BuildContext inContext, Widget inChild, CacheModel inModel) {
          return Scaffold(
              appBar: AppBar(
                title: SliverAppBar(
                  floating: true,
                  snap: true,
                  title: Text("Search App"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: inContext,
                          delegate: NewsSearchDelegate(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: (cacheModel.newsList.isNotEmpty)
                  ? ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: cacheModel.getResult().length,
                      itemBuilder: (BuildContext inBuildContext, int inIndex) {
                        News news = cacheModel.resultList[inIndex];
                        var month = news.dateTime.month;
                        var day = news.dateTime.day;
                        var hour = news.dateTime.hour;
                        var minute = news.dateTime.minute;
                        return Column(children: [
                          ListTile(
                            title: SizedBox.fromSize(
                              child: Text(
                                news.title,
                                textScaleFactor: 1,
                              ),
                            ),
                            subtitle: SizedBox.fromSize(
                              child: Text(
                                news.description,
                                textScaleFactor: 0.8,
                              ),
                            ),
                            trailing: SizedBox.fromSize(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${news.site}",
                                    textScaleFactor: 1,
                                  ),
                                  Text(
                                    "$month.$day at $hour:$minute",
                                    textScaleFactor: 0.8,
                                  ),
                                ],
                              ),
                              size: Size(90, 60),
                            ),
                            onTap: () async {
                              cacheModel.newsToView = NewsDBWorker.db.get(news.id);
                              cacheModel.setStackIndex(1);
                            },
                          ),
                          Divider()
                        ]);
                      },
                    )
                  : Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text("History is empty"),
                        SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              cacheModel.loadData();
                            },
                            child: Text("Reload")),
                      ]),
                    ));
        },
      ),
    );
  }
}