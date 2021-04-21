import 'package:sqflite/sqflite.dart';
import 'NewsModel.dart';
import 'package:news_observer/utils.dart' as util;
import 'package:path/path.dart';
import 'News.dart';

class NewsDBWorker {

  NewsDBWorker._();

  static final NewsDBWorker db = NewsDBWorker._();

  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }

    print("## NewsDBWorker.get-database db = $_db");

    return _db;
  }

  Future<Database> init() async {
    print("## NewsDBWorker.init()");

    String path = join(util.docsDir.path, "news.db");
    print("## NewsDBWorker.init(): path = $path");

    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
          await inDB.execute(
              "CREATE TABLE IF NOT EXISTS news ("
                  "id INTEGER PRIMARY KEY,"
                  "title TEXT,"
                  "description TEXT,"
                  "site TEXT,"
                  "link TEXT,"
                  "date TEXT"
                  ")"
          );
        }
    );
    return db;
  }

  News newsFromMap(Map inMap) {

    print("## NewsDBWorker.newsFromMap() : inMap = $inMap");

    News news = News();
    news.id = inMap["id"];
    news.title = inMap["title"];
    news.description = inMap["description"];
    news.link = inMap["link"];
    news.site = inMap["site"];
    news.dateTime = DateTime(inMap["date"]);

    print("## NewsDBWorker.newsFromMap() : news = $news");

    return news;
  }

  Map<String, dynamic> newsToMap(News inNews){
    print("## NewsDBWorker.newsToMap() : inNews = $inNews");

    Map<String,dynamic> map = Map<String,dynamic>();
    map["id"] = inNews.id;
    map["title"] = inNews.title;
    map["description"] = inNews.description;
    map["link"] = inNews.link;
    map["site"] = inNews.site;
    map["date"] = inNews.dateTime.toString();

    print("## NewsDBWorker.newsToMap() : map = $map");
    return map;
  }

  Future create(News inNews) async{
    print("## NewsDBWorker.create() : inNews = $inNews ");

    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM news");
    int id = val.first["id"];
    if(id == null) {id = 1;}

    inNews.id = id;
    return db.insert("news", newsToMap(inNews));
  }

  Future<News> get(int inID) async{
    print("## NewsDBWorker.get() : inID = $inID");

    Database db = await database;
    var rec = await db.query("news", where: "id = ?", whereArgs: [inID]);
    print("## NewsDBWorker.get() : rec.first = $rec.first");
    return newsFromMap(rec.first);
  }

  Future<bool> isExist(News inNews) async{
    print("## NewsDBWorker.isExist() : description = ${inNews.description}");

    Database db = await database;
    var rec = await db.query("news", where: "description = ?", whereArgs: [inNews.description]);
    print("## NewsDBWorker.get() : rec.first = $rec.first");
    return rec.isEmpty ? true : false;
  }

  Future<List<News>> getAll() async {
    print("## NewsDBWorker.getAll()");

    Database db = await database;
    var recs = await db.query("news");
    var list = recs.isNotEmpty ? recs.map((e) => newsFromMap(e)).toList() : [];

    print("## NewsDBWorker.getAll() : list = $list");
    return list;
  }

  Future update(News inNews) async{
    print("## NewsDBWorker.update(): inNews = $inNews");

    Database db = await database;
    return await db.update("news", newsToMap(inNews), where: "id = ?", whereArgs: [inNews.id]);
  }

  Future delete(int inID) async{
    print("## NewsDBWorker.delete() : inID = $inID");

    Database db = await database;
    return await db.delete("news", where: "id = ?", whereArgs: [inID]);
  }
}