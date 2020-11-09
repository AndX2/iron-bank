import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'stage_env.config.dart';

/// Окружение для предрелизного тестирования
const Environment stage = Environment('stage');

final stageGetIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib', 'test'],
)
void initDiTest() {
  $initGetIt(
    stageGetIt,
    environmentFilter: NoEnvOrContains(stage.name),
  );
}
