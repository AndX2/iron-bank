import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/settings.dart';
import 'package:iron_bank/gateway/common/api_routes.dart';
import 'package:iron_bank/gateway/settings/settings_response.dart';

@injectable
@prod
class SettingsRepository {
  final Dio _client;

  SettingsRepository(@Named('settings') this._client);

  Future<Settings> fetchSettings() {
    return _client
        .get(ApiRoutes.settingsUrl)
        .then((response) => SettingsResponse.fromJson(response).parse());
  }
}
