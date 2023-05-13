
class ApiUrls {
  static String get _baseUrl => 'http://192.168.1.117:8000/api/';

  static String get _auth => 'otp/';
  static String get _mobile => 'mobile/';

  static String get login => '$_baseUrl${_auth}login';

  static String get otpVerification => '$_baseUrl${_auth}verification';

  static String get getProfile => '$_baseUrl${_mobile}profile';

  static String get createOrUpdateProfile => '$_baseUrl${_mobile}update-profile';

  static String get changePassword => '$_baseUrl${_mobile}change-password';
}
