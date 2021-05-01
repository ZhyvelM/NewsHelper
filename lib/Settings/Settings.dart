import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/LiveModel.dart' show liveModel;
import 'package:news_observer/utils.dart' as utils;

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State {
  bool tutby = utils.prefs.getBool("tutby");
  bool sputnik = utils.prefs.getBool("sputnik");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
