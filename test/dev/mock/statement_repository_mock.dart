import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/statement/statement_repository.dart';

@Injectable(
  as: StatementRepository,
  env: [Environment.dev],
)
class StatementRepositoryMock implements StatementRepository {
  @override
  Future<Money> fetchBalance() async {
    await Future.delayed(Duration(seconds: 3));
    return Money.from(
      goldenDragons: 3,
      silverDeers: 53,
      copperPenny: 160,
    );
  }
}
