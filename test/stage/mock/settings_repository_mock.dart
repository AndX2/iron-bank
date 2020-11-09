import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/settings.dart';
import 'package:iron_bank/gateway/settings/settings_repository.dart';

import '../stage_env.dart';

@Injectable(as: SettingsRepository)
@stage
class SettingsRepositoryMock implements SettingsRepository {
  @override
  Future<Settings> fetchSettings() async {
    await Future.delayed(Duration(seconds: 3));
    return Settings('https://stage.iron-bank.com');
  }
}
