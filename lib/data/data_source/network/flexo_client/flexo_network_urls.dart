abstract class FlexoNetworkUrls {
  // ************* Authentications *************
  static const String auth = '/auth';
  static const String login = '$auth/login';
  static const String signup = '$auth/signup';
  static const String refreshToken = '$auth/refresh-token';

  // ************* Sensors *************
  static const String sensors = '/sensors';

  static const String report = '$sensors/report';
  static const String upload = '$sensors/upload';

  static bool requireAuthentication(String url) {
    return ![
      signup,
      login,
    ].contains(url);
  }
}
