import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/di/di_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void initDi() {
  $initGetIt(
    getIt,
    environmentFilter: NoEnvOrContains(Environment.prod),
  );
}
