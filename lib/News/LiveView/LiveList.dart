import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_observer/News/CacheView/CacheModel.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils.dart' as utils;
import '../News.dart';
import '../NewsSearchService.dart';
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
              body: Column(children: [
            SearchWidget(liveModel.date, liveModel),
            FutureBuilder(builder: (BuildContext inBuildContext, AsyncSnapshot<bool> snapshot) {
              if (liveModel.isLoading) {
                return Center(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 30,
                        height: 30,
                      )),
                );
              } else
                return (liveModel.resultList.length > 0)
                    ? Expanded(
                        child: RefreshIndicator(
                            onRefresh: liveModel.reload,
                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              itemCount: liveModel.resultList.length,
                              itemBuilder: (BuildContext inBuildContext, int inIndex) {
                                News news = liveModel.resultList[inIndex];
                                return Column(children: [
                                  Slidable(
                                    child: NewsTile(news),
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    secondaryActions: [
                                      IconSlideAction(
                                        caption: "Archive",
                                        color: Colors.blue,
                                        icon: Icons.cloud_download_outlined,
                                        onTap: () {
                                          liveModel.loadToDb(news);
                                          cacheModel.loadData();
                                          utils.showMessage(inContext, "News archived");
                                        },
                                      )
                                    ],
                                  ),
                                  Divider()
                                ]);
                              },
                            )))
                    : Container(
                        height: 400,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Nothing was found or network error happened"),
                              ElevatedButton(
                                  onPressed: () {
                                    liveModel.reload();
                                  },
                                  child: Text("Load news")),
                            ]));
            })
          ]));
        },
      ),
    );
  }
}
