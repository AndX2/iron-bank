import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/settings.dart';
import 'package:iron_bank/gateway/settings/settings_repository.dart';

@singleton
class SettingsService {
  final SettingsRepository _settingsRepository;

  Settings _settings;

  SettingsService(this._settingsRepository);

  Future<Settings> fetchSettings() async {
    if (_settings == null)
      _settings = await _settingsRepository.fetchSettings();
    return _settings;
  }
}
