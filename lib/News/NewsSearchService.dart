import 'package:flutter/material.dart';
import 'package:news_observer/News/LiveView/LiveModel.dart';
import 'package:news_observer/News/NewsModel.dart';
import 'package:news_observer/utils.dart' as utils;

import 'News.dart';

class NewsSearchDelegate extends SearchDelegate {
  List<News> listOfNews;

  NewsSearchDelegate(this.listOfNews);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<News> resultList =
    listOfNews.where((element) => element.title.toLowerCase().contains(query.toLowerCase()));

    if (resultList.isEmpty) {
      return Center(
        child: Text("Nothing found"),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      itemCount: resultList.length,
      itemBuilder: (BuildContext inBuildContext, int inIndex) {
        News news = resultList[inIndex];
        return Column(children: [
          NewsTile(news),
          Divider()
        ]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final resultList = listOfNews
        .where((element) => element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: resultList.length,
        itemBuilder: (BuildContext inBuildContext, int inIndex) {
          String title = resultList[inIndex].title;
          return Column(
            children: [
              ListTile(
                title: Text(title),
                onTap: () {
                  query = title;
                },
              ),
              Divider()
            ],
          );
        });
  }
}

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  DateTime date;
  NewsModel model;

  SearchWidget(DateTime inDate, NewsModel inModel) {
    date = inDate;
    model = inModel;
  }

  @override
  Widget build(BuildContext inContext) {
    return Row(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: ElevatedButton(
          onPressed: () async {
            DateTime picked = await utils.selectDate(inContext, model);
            print("## Chosen date: $picked");
            if(picked == null){
              picked = DateTime.now();
            }
            model.setChosenDate(picked);
          },
          child: Text(
            "CHANGE DATE",
            textScaleFactor: 1,
          ),
        ),
      ),
      Spacer(),
      Text(
        model.date != null ? "${date.day}.${date.month}.${date.year}" : (model is LiveModel)
            ? "${DateTime.now().day}."
            "${DateTime.now().month}."
            "${DateTime.now().year}"
            : "WHOLE HISTORY",
        textScaleFactor: 1.7,
      ),
      Spacer(),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: inContext,
            delegate: NewsSearchDelegate(model.newsList),
          );
        },
      )
    ]);
  }
}
