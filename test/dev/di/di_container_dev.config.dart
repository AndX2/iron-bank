// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/gateway/http_client/dio_client.dart';
import 'package:iron_bank/gateway/scoring/scoring_repository.dart';
import 'package:iron_bank/service/scoring_service.dart';
import 'package:iron_bank/gateway/http_client/settings_interceptor.dart';
import 'package:iron_bank/gateway/settings/settings_repository.dart';
import 'package:iron_bank/service/settings_service.dart';
import 'package:iron_bank/gateway/statement/statement_repository.dart';
import 'package:iron_bank/service/statement_service.dart';
import 'package:iron_bank/gateway/winter/winter_repository.dart';
import 'package:iron_bank/service/winter_service.dart';

import '../mock/scoring_repository_mock.dart';
import '../../integration/mock/scoring_repository_mock.dart' as iron_bank1;
import '../mock/settings_repository_mock.dart';
import '../../integration/mock/settings_repository_mock.dart' as iron_bank2;
import '../../stage/mock/settings_repository_mock.dart' as iron_bank4;
import '../mock/statement_repository_mock.dart';
import '../../integration/mock/statement_repository_mock.dart' as iron_bank3;
import '../mock/winter_repository_mock.dart';
import '../../integration/mock/winter_repository_mock.dart' as iron_bank;

/// Environment names
const _prod = 'prod';
const _test = 'test';
const _dev = 'dev';
const _stage = 'stage';

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
  gh.factory<ScoringRepository>(() => ScoringRepositoryMock(),
      registerFor: {_test});
  gh.factory<ScoringRepository>(() => iron_bank1.ScoringRepositoryMock(),
      registerFor: {_dev});
  gh.factory<SettingsRepository>(
      () => SettingsRepository(get<Dio>(instanceName: 'settings')),
      registerFor: {_prod});
  gh.factory<SettingsRepository>(() => SettingsRepositoryMock(),
      registerFor: {_dev});
  gh.factory<SettingsRepository>(() => iron_bank2.SettingsRepositoryMock(),
      registerFor: {_test});
  gh.factory<SettingsRepository>(() => iron_bank4.SettingsRepositoryMock(),
      registerFor: {_stage});
  gh.factory<StatementRepository>(() => StatementRepository(get<Dio>()),
      registerFor: {_prod});
  gh.factory<StatementRepository>(() => StatementRepositoryMock(),
      registerFor: {_dev});
  gh.factory<StatementRepository>(() => iron_bank3.StatementRepositoryMock(),
      registerFor: {_test});
  gh.factory<WinterRepository>(
      () => WinterRepository(get<Dio>(instanceName: 'winter')),
      registerFor: {_prod});
  gh.factory<WinterRepository>(() => WinterRepositoryMock(),
      registerFor: {_dev});
  gh.factory<WinterRepository>(() => iron_bank.WinterRepositoryMock(),
      registerFor: {_test});
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
