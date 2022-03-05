import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPref;

  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is double) return await sharedPref.setDouble(key, value);
    else if (value is int) return await sharedPref.setInt(key, value);
    else if (value is bool) return await sharedPref.setBool(key, value);

    else return await sharedPref.setString(key, value);
  }

  static dynamic getData(key)
  {
    return sharedPref.get(key);
  }

  static Future<bool> remove(key) async
  {
    return await sharedPref.remove(key) ;
  }
}

// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper{
//   static SharedPreferences? sharedPref;
//   static init() async{
//     sharedPref = await SharedPreferences.getInstance();
//   }
//
//   static Future<bool> saveData ({
//   required String key,
//     required dynamic value,
// })async{
//     if (value is String) return await sharedPref!.setString(key, value);
//     else if (value is double) return await sharedPref!.setDouble(key, value);
//     else if (value is int) return await sharedPref!.setInt(key, value);
//     else return await sharedPref!.setBool(key, value);
//   }
//   static dynamic? getData({required String key}){
//     return sharedPref!.get(key);
//   }
// }

