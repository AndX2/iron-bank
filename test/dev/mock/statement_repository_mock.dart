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
    await await Future.delayed(Duration(seconds: 3));
    return Money.from(silverDeers: 53);
  }
}
