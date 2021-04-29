import 'package:flutter/material.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';
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
              body: (cacheModel.resultList.length > 0)?
              Column(
                  children: [
                    SearchWidget(cacheModel.date, cacheModel),
                    Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          itemCount: cacheModel.resultList.length,
                          itemBuilder: (BuildContext inBuildContext, int inIndex) {
                            News news = cacheModel.resultList[inIndex];
                            return Column(
                                children: [
                                  NewsTile(news),
                                  Divider()
                                ]
                            );
                          },
                        ))
                  ])
                  : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("History is empty"),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        utils.selectDate(inContext, cacheModel);
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
