import 'package:flutter/material.dart';
import 'package:news_observer/News/CacheView/CacheModel.dart';
import 'package:news_observer/News/LiveView/LiveModel.dart' show liveModel;
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/utils.dart' as utils;

class Settings extends StatefulWidget {
  Settings(BuildContext context) {
    inContext = context;
  }

  BuildContext inContext;

  @override
  SettingsState createState() => SettingsState(inContext);
}

class SettingsState extends State {
  SettingsState(BuildContext context) {
    inContext = context;
  }

  BuildContext inContext;
  String color = utils.prefs.getString("color");
  bool tutby = utils.prefs.getBool("tutby");
  bool sputnik = utils.prefs.getBool("sputnik");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("TUT.BY"),
                        trailing: Checkbox(
                          value: tutby,
                          onChanged: (val) {
                            setState(() {
                              tutby = val;
                              utils.prefs.setBool("tutby", val);
                              liveModel.loadData();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("SPUTNIK"),
                        trailing: Checkbox(
                          value: sputnik,
                          onChanged: (val) {
                            setState(() {
                              sputnik = val;
                              utils.prefs.setBool("sputnik", val);
                              liveModel.loadData();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Card(
                child: ListTile(
                  title: Text("Clear cache"),
                  onTap: () {
                    NewsDBWorker.db.clearBase();
                    cacheModel.loadData();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
