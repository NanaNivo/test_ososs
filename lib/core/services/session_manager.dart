
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_ososs/core/localization/app_lang.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  static const keyToken = "USER_TOKEN";
  static const keyLang="Lang";
  static const authorizeToken = "authorization";
  static const refreshKeyToken = "REFRESH_USER_TOKEN";
  final _storage = const FlutterSecureStorage();

  factory SessionManager() {
    return _instance;
  }
  SessionManager._internal();

  Future<void> deleteLang() async
  {
    await _storage.delete(key: keyLang);
    return;
  }
  Future<void> persistLang(String lang) async
  {
    _storage.write(key: keyLang, value: lang);
    return;
  }

  Future<AppLanguages> get LangApp async {
   String temp= await _storage.read(key: keyLang);
   AppLanguages appLanguages=AppLanguages.en;
   if(temp==AppLanguages.en.name)
     {
       print("gggg");
       appLanguages=AppLanguages.en;
     }
   else
     {
       appLanguages=AppLanguages.es;
     }
    return appLanguages;

  }

  Future<void> deleteToken() async {
    await _storage.delete(key: keyToken);
    return;
  }



  Future<void> persistToken(String token) async {
     _storage.write(key: keyToken, value: token);
    return;
  }

  Future<void> persistRefreshToken(String token) async {
    _storage.write(key: refreshKeyToken, value: token);
    return;
  }

  Future<String> get authToken async {
    return await _storage.read(key: keyToken);
  }

  Future<bool> get hasToken async {
   return await _storage.containsKey(key: keyToken);
  }
  Future<String> get refreshToken async {
    return await _storage.read(key: refreshKeyToken);
  }

}
