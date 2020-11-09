import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/service/settings_service.dart';

@injectable
class SettingsInterceptor extends InterceptorsWrapper {
  final SettingsService _settingsService;

  SettingsInterceptor(this._settingsService);

  @override
  Future onRequest(RequestOptions options) async {
    final settings = await _settingsService.fetchSettings();
    options.baseUrl = settings.baseUrl;
    return super.onRequest(options);
  }
}
