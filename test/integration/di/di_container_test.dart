import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_container_test.config.dart';

final testGetIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib', 'test'],
)
void initDiTest() {
  $initGetIt(
    testGetIt,
    environmentFilter: NoEnvOrContains(Environment.test),
  );
}
