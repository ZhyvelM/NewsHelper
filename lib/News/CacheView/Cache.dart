import 'package:flutter/material.dart';
import 'package:news_observer/News/CacheView/CacheList.dart';
import 'CacheModel.dart' show CacheModel, cacheModel;
import 'package:news_observer/News/NewsOverview.dart';
import 'package:scoped_model/scoped_model.dart';

class Cache extends StatelessWidget{

  Cache(){
    print("## Cache.constructor");
    cacheModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CacheModel>(
      model: cacheModel,
      child: ScopedModelDescendant<CacheModel>(
        builder: (BuildContext inContext, Widget inChild, CacheModel inModel){
          return IndexedStack(
            index: inModel.stackIndex,
            children: [
              CacheList(),
              NewsOverview()
            ],
          );
        },
      ),
    );
  }

}
