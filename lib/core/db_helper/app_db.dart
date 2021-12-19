import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stb_cat_app/features/models/cat.dart';
import 'package:stb_cat_app/features/models/cat_api.dart';
import 'package:http/http.dart' as http;
import 'package:stb_cat_app/features/repository/cache_repo.dart';
import 'package:uuid/uuid.dart';


class AppDB {
  static Database? _db;
  static const String ID = 'id';
  static const String NAME = 'photo_name';
  static const String IMAGESOURCE = 'image_source';

  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'photos2.db';

  CacheImage cacheImage = CacheImage();
  var uuid = const Uuid();

  Future<Database?> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + DB_NAME;
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT ,$IMAGESOURCE TEXT)");
  }

}
