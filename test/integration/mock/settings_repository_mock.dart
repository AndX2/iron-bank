import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/settings.dart';
import 'package:iron_bank/gateway/settings/settings_repository.dart';

@Injectable(as: SettingsRepository, env: [Environment.test])
class SettingsRepositoryMock implements SettingsRepository {
  @override
  Future<Settings> fetchSettings() async {
    await Future.delayed(Duration(seconds: 3));
    return Settings('https://iron-bank.com');
  }
}
