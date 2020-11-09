import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/gateway/http_client/settings_interceptor.dart';

@module
abstract class RegisterHttpClient {
  @Named('settings')
  Dio createSettingsClient() {
    final options = BaseOptions(
      baseUrl: 'https://iron-bank.com/',
      connectTimeout: 10000,
      sendTimeout: 10000,
    );
    return Dio(options);
  }

  @Named('winter')
  Dio createWinterClient() {
    final options = BaseOptions(
      baseUrl: 'https://winter.com/',
      connectTimeout: 10000,
      sendTimeout: 10000,
    );
    return Dio(options);
  }

  Dio createBankClient(SettingsInterceptor settingsInterceptor) {
    final options = BaseOptions(
      connectTimeout: 10000,
      sendTimeout: 10000,
    );
    return Dio(options)
      ..interceptors.addAll([
        settingsInterceptor,
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      ]);
  }
}
