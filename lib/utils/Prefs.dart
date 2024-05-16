
import 'package:encrypt/encrypt.dart';
import 'package:lmsystem_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static setString(String key,String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, SecurityUtils.encryptAES(value));
  }

  static Future<String> getString(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) == null ? "" : SecurityUtils.decryptAES(Encrypted.fromBase64(prefs.getString(key)!));
  }

  static setBoolean(String key,bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    return true;
  }

  static Future<bool> getBoolean(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static clearPreferences() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static removePreference(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

}