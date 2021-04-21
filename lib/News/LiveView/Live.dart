import 'package:flutter/material.dart';
import 'LiveModel.dart' show LiveModel, liveModel;
import 'package:news_observer/News/NewsOverview.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:news_observer/News/LiveView/LiveList.dart';

class Live extends StatelessWidget{
  Live(){
    print("## Live.constructor");
    liveModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LiveModel>(
      model: liveModel,
      child: ScopedModelDescendant<LiveModel>(
        builder: (BuildContext inContext, Widget inChild, LiveModel inModel){
          return IndexedStack(
            index: inModel.stackIndex,
            children: [
              LiveList(),
              NewsOverview()
            ],
          );
        },
      ),
    );
  }

}