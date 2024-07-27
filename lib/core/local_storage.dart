import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final _pref = GetStorage();
  static Future<String> getUserName() async {
    try {
      var user = await _pref.read('userName');
      return user ?? '';
    } catch (e) {
      rethrow;
    }
  }

  static Future setUserName({required String name}) async {
    try {
      await _pref.write('userName', name);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getUserId() async {
    try {
      var user = await _pref.read('uid');
      return user ?? '';
    } catch (e) {
      rethrow;
    }
  }

  static Future setUserId({required String uid}) async {
    try {
      await _pref.write('uid', uid);
    } catch (e) {
      rethrow;
    }
  }

  static Future clear() async {
    await _pref.remove('uid');
    await _pref.remove('userName');
  }
}
