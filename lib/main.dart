import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_observer/News/CacheView/Cache.dart';
import 'package:news_observer/News/LiveView/Live.dart';
import 'package:news_observer/Settings/Settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart' as utils;

void main() {
  startMeUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    Directory docsDir = await getApplicationDocumentsDirectory();
    utils.prefs = await SharedPreferences.getInstance();
    if (utils.prefs.getKeys() == null || utils.prefs.getKeys().isEmpty) {
      print("## main preferences init");
      utils.prefs.setBool("tutby", true);
      utils.prefs.setBool("sputnik", true);
    }
    utils.docsDir = docsDir;
    runApp(MyApp());
  }

  startMeUp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.assignment),
                    text: "News",
                  ),
                  Tab(
                    icon: Icon(Icons.cloud_download),
                    text: "Cached",
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: "Settings",
                  )
                ],
              ),
            ]),
          ),
          body: TabBarView(
            children: [Live(), Cache(), Settings()],
          ),
        ),
      ),
    );
  }
}
