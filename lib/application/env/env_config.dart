enum ENV {
  dev,
  staging,
  customer;

  String get toStringValue {
    switch (this) {
      case ENV.dev:
        return 'dev';
      case ENV.staging:
        return 'staging';
      case ENV.customer:
        return 'customer';
      default:
        return '';
    }
  }

  static ENV fromServer(String? value) {
    switch (value) {
      case 'dev':
        return ENV.dev;
      case 'staging':
        return ENV.staging;
      case 'customer':
        return ENV.customer;
      default:
        return EnvConfigApp.env;
    }
  }
}

enum BUILD { debug, release }

class EnvApp {
  final String endpoint;

  EnvApp({
    required this.endpoint,
  });
}

class EnvConfigApp {
  static var env = ENV.dev;
  static const build = BUILD.release;

  static EnvApp getEnv() {
    switch (env) {
      case ENV.dev:
        const endpoint = 'https://u6sckjsag4.execute-api.ap-southeast-1.amazonaws.com/dev';

        return EnvApp(
          endpoint: endpoint,
        );
      case ENV.staging:
        const endpoint = '';

        return EnvApp(
          endpoint: endpoint,
        );
      case ENV.customer:
        const endpoint = '';

        return EnvApp(
          endpoint: endpoint,
        );
    }
  }
}
