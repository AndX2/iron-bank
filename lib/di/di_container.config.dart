// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../gateway/http_client/dio_client.dart';
import '../gateway/scoring/scoring_repository.dart';
import '../service/scoring_service.dart';
import '../gateway/http_client/settings_interceptor.dart';
import '../gateway/settings/settings_repository.dart';
import '../service/settings_service.dart';
import '../gateway/statement/statement_repository.dart';
import '../service/statement_service.dart';
import '../gateway/winter/winter_repository.dart';
import '../service/winter_service.dart';

/// Environment names
const _prod = 'prod';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerHttpClient = _$RegisterHttpClient();
  gh.factory<Dio>(() => registerHttpClient.createSettingsClient(),
      instanceName: 'settings');
  gh.factory<Dio>(() => registerHttpClient.createWinterClient(),
      instanceName: 'winter');
  gh.factory<ScoringRepository>(() => ScoringRepository(get<Dio>()),
      registerFor: {_prod});
  gh.factory<SettingsRepository>(
      () => SettingsRepository(get<Dio>(instanceName: 'settings')),
      registerFor: {_prod});
  gh.factory<StatementRepository>(() => StatementRepository(get<Dio>()),
      registerFor: {_prod});
  gh.factory<WinterRepository>(
      () => WinterRepository(get<Dio>(instanceName: 'winter')),
      registerFor: {_prod});
  gh.factory<SettingsInterceptor>(
      () => SettingsInterceptor(get<SettingsService>()));
  gh.factory<Dio>(
      () => registerHttpClient.createBankClient(get<SettingsInterceptor>()));

  // Eager singletons must be registered in the right order
  gh.singleton<SettingsService>(SettingsService(get<SettingsRepository>()));
  gh.singleton<StatementService>(StatementService(get<StatementRepository>()));
  gh.singleton<WinterService>(WinterService(get<WinterRepository>()));
  gh.singleton<ScoringService>(
      ScoringService(get<ScoringRepository>(), get<WinterService>()));
  return get;
}

class _$RegisterHttpClient extends RegisterHttpClient {}
