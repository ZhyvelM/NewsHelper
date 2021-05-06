import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class News {
  int id;
  String title;
  String description;
  String site;
  String link;
  DateTime dateTime;

  @override
  String toString() {
    return "id:$id title:$title description:$description site:$site link:$link date:$dateTime";
  }
}

// ignore: must_be_immutable
class NewsTile extends StatelessWidget {
  News news;

  NewsTile(News inNews) {
    this.news = inNews;
  }

  @override
  Widget build(BuildContext inContext) {
    var month = news.dateTime.month;
    var day = news.dateTime.day;
    var hour = news.dateTime.hour;
    var minute = news.dateTime.minute;

    return ListTile(
      title: Text(
        news.title,
        textScaleFactor: 1,
      ),
      subtitle: Row(children: [
        Flexible(
          child: Text(
            news.description,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 0.8,
          ),
        ),
      ]),
      trailing: SizedBox.fromSize(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${news.site}",
              textScaleFactor: 1,
            ),
            Text(
              "$month.$day at $hour:$minute",
              textScaleFactor: 0.8,
            ),
          ],
        ),
        size: Size(90, 60),
      ),
      onTap: () async {
        var url = news.link;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      onLongPress: () {
        Share.share(news.link.toString());
      },
    );
  }
}
