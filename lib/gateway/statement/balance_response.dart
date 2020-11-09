import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/common/parcelable.dart';

class BalanceResponse extends Parcelable<Money> {
  int dragons;
  int deers;
  int penny;

  @override
  BalanceResponse.fromJson(dynamic json) {
    final arrValue = (json as String).split('.');
    dragons = int.parse(arrValue[0]);
    deers = int.parse(arrValue[1]);
    penny = int.parse(arrValue[2]);
  }

  @override
  Money parse() {
    return Money.from(
      goldenDragons: dragons,
      silverDeers: deers,
      copperPenny: penny,
    );
  }
}
