
import 'package:shared_preferences/shared_preferences.dart';
class CacheImage{

  saveImageCache( String baseImg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseImg', baseImg);
  }

  Future<String> getCacheImage()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('baseImg') ?? '';
  }

}

