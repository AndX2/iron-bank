import 'package:flutter/foundation.dart';

const int _rateCopperToSilver = 56;
const int _rateSilverToGold = 210;

/// Объект денег
@immutable
class Money {
  /// Количество грошей
  final int rowValue;

  Money.from({
    /// Золотые драконы
    int goldenDragons = 0,

    /// Серебрянные олени
    int silverDeers = 0,

    /// Медные гроши
    int copperPenny = 0,
  })  : assert(goldenDragons >= 0),
        assert(silverDeers >= 0),
        assert(copperPenny >= 0),
        rowValue = copperPenny +
            silverDeers * _rateCopperToSilver +
            goldenDragons * _rateSilverToGold * _rateCopperToSilver;

  @override
  String toString() {
    return '$goldenDragons.$silverDeers.$copperPenny';
  }
}

extension MoneyExt on Money {
  /// Золотые драконы
  int get goldenDragons =>
      rowValue ~/ (_rateSilverToGold * _rateCopperToSilver);

  /// Серебрянные олени
  int get silverDeers {
    return (rowValue -
            (goldenDragons * (_rateSilverToGold * _rateCopperToSilver))) ~/
        _rateCopperToSilver;
  }

  /// Медные гроши
  int get copperPenny =>
      rowValue -
      goldenDragons * (_rateSilverToGold * _rateCopperToSilver) -
      silverDeers * _rateCopperToSilver;
}
