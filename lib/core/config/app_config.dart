// here we have the settings for prod
// ignore_for_file: prefer_interpolation_to_compose_strings

const String _prodUrl = '';

// here we have the settings for dev
const String _devUrl = '146.190.74.11';

class AppConfig {
  AppConfig();

  // Given we cannot switch between live and dev in the live-app
  // it should be done manually here instead.
  static bool isProd = false;

  static String get apiProtocol {
    return AppConfig.isProd ? 'https' : 'http';
  }

  static String get apiDomain {
    return AppConfig.isProd ? _prodUrl : _devUrl;
  }

  static String apiPath(String path) {
    return '/api/v1/' + (path.startsWith('/') ? path.substring(1) : path);
  }

  static String apiFullPath(String path) {
    return AppConfig.apiProtocol +
        '://' +
        AppConfig.apiDomain +
        '/api/v1/' +
        (path.startsWith('/') ? path.substring(1) : path);
  }
}
