import 'package:news_observer/News/LiveView/NewsGetter.dart';
import 'package:news_observer/News/NewsDBWorker.dart';
import 'package:news_observer/News/NewsModel.dart';

import '../News.dart';

class LiveModel extends NewsModel {
  @override
  void loadData() async {
    isLoading = true;
    if (date == null) date = DateTime.now();
    newsList = await NewsGetter.parser.getNews(date);
    print("## LiveModel.loadData(): date = $date");
    print("## LiveModel.loadData(): newsList.length = ${newsList.length}");
    getResult();
    isLoading = false;
    notifyListeners();
  }

  Future<void> reload() async {
    print("## LiveModel.reload()");
    isLoading = true;
    notifyListeners();
    loadData();
  }

  void loadToDb(News inNews) {
    NewsDBWorker.db.create(inNews);
  }
}

LiveModel liveModel = LiveModel();
