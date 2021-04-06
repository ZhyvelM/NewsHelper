import 'package:sqflite/sqflite.dart';
import 'ListModel.dart';
import 'package:news_observer/utils.dart' as util;
import 'package:path/path.dart';

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
    print("## news NewsDBWorker.init(): path = $path");

    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
          await inDB.execute(
              "CREATE TABLE IF NOT EXISTS news ("
                  "id INTEGER PRIMARY KEY,"
                  "title TEXT,"
                  "description TEXT,"
                  "site TEXT,"
                  "link TEXT,"
                  "date DATETIME"
                  ")"
          );
        }
    );
    return db;
  }
}