import 'package:flutter_test/flutter_test.dart';
import 'package:iron_bank/di/di_container.dart';
import 'package:iron_bank/domain/error/winter_has_come_exception.dart';
import 'package:iron_bank/service/scoring_service.dart';

import 'di/di_container_test.dart';

main() {
  setUpAll(
    () => initDiTest(),
  );

  group(
    'Группа тестов для условия наступившей зимы',
    () {
      getCreditLimitWhileWinterHasCome();
    },
  );
}

void getCreditLimitWhileWinterHasCome() {
  test(
    'Тест логики запроса кредитного лимита если наступила зима',
    () async {
      expect(
        () async => getIt.get<ScoringService>().getCreditLimit(),
        throwsA((error) => error is WinterHasComeException),
      );
    },
  );
}
