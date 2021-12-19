import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stb_cat_app/core/db_helper/app_db.dart';
import 'package:stb_cat_app/features/models/cat.dart';
import 'package:stb_cat_app/features/models/cat_api.dart';

class DBHelper extends AppDB {
  Future<bool> save(Photo employee) async {
    var dbClient = await db;
    int added = (await dbClient!.insert(AppDB.TABLE, employee.toMap()));
    return added == 1 ? true : false;
  }

  Future<bool> deletePhoto(String id) async {
    var dbClient = await db;
    int deleted =
        await dbClient!.delete(AppDB.TABLE, where: 'ID = ?', whereArgs: [id]);
    return deleted == 1 ? true : false;
  }

  Future<int> update(Photo photo) async {
    var dbClient = await db;
    return await dbClient!.update(AppDB.TABLE, photo.toMap(),
        where: 'ID = ?', whereArgs: [photo.id]);
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!
        .query(AppDB.TABLE, columns: [AppDB.ID, AppDB.NAME, AppDB.IMAGESOURCE]);
    List<Photo> photos = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(Photo.fromMap(maps[i]));
      }
    }
    return photos;
  }

  Future<bool> addToDb(
    String url,
    String name,
  ) async {
    http.Response response = await http.get(
      Uri.parse(url),
    );

    var _baseTest = const Base64Encoder().convert(response.bodyBytes);
    bool added = await save(Photo(uuid.v4(), name, _baseTest));
    return added ? true : false;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }

  Future<List<CatApi>> getCatRemote([bool remote = false]) async {
    final http.Response response;
    List<dynamic> locationJson = [];
    if (await cacheImage.getCacheImage() == '' || remote) {
      final Uri url = Uri.parse('https://api.thecatapi.com/v1/images/search');
      response = await http.get(url);
      locationJson = jsonDecode(
        response.body,
      );
      saveImageForCache(response.body);
    } else {
      locationJson = jsonDecode(await cacheImage.getCacheImage());
    }
    final List<CatApi> list = locationJson
        .map(
          (dynamic e) => CatApi.fromJson(e),
        )
        .toList();
    return list;
  }

  saveImageForCache(String body) async {
    cacheImage.saveImageCache(body);
  }
}
