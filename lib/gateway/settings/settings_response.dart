import 'package:iron_bank/domain/settings.dart';
import 'package:iron_bank/gateway/common/parcelable.dart';

class SettingsResponse extends Parcelable<Settings> {
  final String baseUrl;

  @override
  SettingsResponse.fromJson(dynamic json) : baseUrl = json['baseUrl'];

  @override
  Settings parse() {
    return Settings(baseUrl);
  }
}
