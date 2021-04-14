import 'package:flutter/material.dart';
import 'utils.dart' as utils;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:news_observer/News/CacheView/Cache.dart';

void main() {
  startMeUp() async{
    WidgetsFlutterBinding.ensureInitialized();
    Directory docsDir = await getApplicationDocumentsDirectory();
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
              flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.assignment), text: "News",),
                        Tab(icon: Icon(Icons.cloud_download), text: "Cached",),
                        Tab(icon: Icon(Icons.settings), text: "Settings",)
                      ],
                    ),
                  ]
              )
          ),
          body: TabBarView(
            children: [
              Scaffold(),
              Cache(),
              Scaffold()
            ],
          ),
        ),
      ),
    );
  }
}
