import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di_container_dev.config.dart';

final devGetIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib', 'test'],
)
void initDiDev() {
  $initGetIt(
    devGetIt,
    environmentFilter: NoEnvOrContains(Environment.dev),
  );
}
