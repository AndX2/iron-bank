import 'package:flutter_test/flutter_test.dart';
import 'package:iron_bank/domain/money.dart';

main() {
  test(
    'Money from 11760 copperPenny',
    () {
      final money = Money.from(copperPenny: 11760);
      print('Money from 11760 copperPenny = $money');
      expect(
          money.goldenDragons == 1 &&
              money.silverDeers == 0 &&
              money.copperPenny == 0,
          true,
          reason: '11760 copperPenny != 1 goldenDragons');
    },
  );
  test(
    'Money from goldenDragons: 13, silverDeers: 125, copperPenny: 568',
    () {
      final money = Money.from(
        goldenDragons: 13,
        silverDeers: 1356,
        copperPenny: 568,
      );
      print(
          'Money from goldenDragons: 13, silverDeers: 125, copperPenny: 568 = $money');
      expect(
        money.goldenDragons == 19 &&
            money.silverDeers == 106 &&
            money.copperPenny == 8,
        true,
      );
    },
  );

  test(
    'Money from negative value',
    () {
      expect(
        () => Money.from(
          goldenDragons: 13,
          silverDeers: -1356,
          copperPenny: 568,
        ),
        throwsAssertionError,
      );
    },
  );
}
