import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'CacheView/CacheModel.dart' show cacheModel, CacheModel;

class NewsOverview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CacheModel>(
      model: cacheModel,
      child: ScopedModelDescendant<CacheModel>(
        builder: (BuildContext inContext, Widget inChild, CacheModel inModel){
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

              ],
            ),
          );
        },
      ),
    );
  }
  
}