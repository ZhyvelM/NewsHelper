import 'package:news_observer/News/News.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class NewsModel extends Model {
  List<News> newsList = [];
  List<News> resultList = [];
  String searchQuery;
  bool isLoading = false;
  DateTime date;

  void loadData();

  void setChosenDate(DateTime inDate) {
    print("## NewsModel.setChosenDate() inDate = $inDate");

    date = inDate;
    notifyListeners();
    loadData();
  }

  void setSearchQuery(String inSearchQuery) {
    print("## NewsModel.setSearchQuery() inSearchQuery = $inSearchQuery");

    searchQuery = inSearchQuery;
    notifyListeners();
  }

  List<News> getResult() {
    resultList = newsList;
    print("## NewsModel.getResult() : resultList = $resultList");
    print("## NewsModel.getResult() : dateTimeRange = $date");
    if (date != null) {
      resultList = resultList
          .where((el) =>
              date.year == el.dateTime.year &&
              date.month == el.dateTime.month &&
              date.day == el.dateTime.day)
          .toList();
    }
    print("## NewsModel.getResult() : resultList.length = ${resultList.length}");
    return resultList;
  }
}
