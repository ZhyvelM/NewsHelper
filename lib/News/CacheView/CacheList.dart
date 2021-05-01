import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../utils.dart' as utils;
import 'package:scoped_model/scoped_model.dart';
import '../News.dart';
import '../NewsSearchService.dart';
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
              body: (cacheModel.resultList.length > 0) ?
              Column(
                  children: [
                    SearchWidget(cacheModel.date, cacheModel),
                    FutureBuilder(
                        builder: (BuildContext inBuildContext, AsyncSnapshot<bool> snapshot) {
                          if (cacheModel.isLoading) {
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
                            return Expanded(
                                child: RefreshIndicator(
                                  onRefresh: cacheModel.loadData,
                                    child: ListView.builder(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      itemCount: cacheModel.resultList.length,
                                      itemBuilder: (BuildContext inBuildContext, int inIndex) {
                                        News news = cacheModel.resultList[inIndex];
                                        return Column(
                                            children: [
                                              Slidable(
                                                child: NewsTile(news),
                                                actionPane: SlidableDrawerActionPane(),
                                                actionExtentRatio: 0.25,
                                                secondaryActions: [
                                                  IconSlideAction(
                                                    caption: "Delete",
                                                    color: Colors.red,
                                                    icon: Icons.cloud_download_outlined,
                                                    onTap: () {
                                                      cacheModel.deleteNews(news.id);
                                                      utils.showMessage(inContext, "News deleted");
                                                    },
                                                  )
                                                ],
                                              ),
                                              Divider()
                                            ]
                                        );
                                      },
                                    )
                                )
                            );
                        })
                  ])
                  : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("History is empty"),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var picked = await utils.selectDate(inContext, cacheModel);
                        cacheModel.setChosenDate(picked);
                      },
                      child: Text("Try change date")
                  ),
                ]
                ),
              )
          );
        },
      ),
    );
  }
}
