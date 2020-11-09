import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/scoring/scoring_repository.dart';

@Injectable(as: ScoringRepository, env: [Environment.test])
class ScoringRepositoryMock implements ScoringRepository {
  @override
  Future<Money> fetchCreditData() async {
    await await Future.delayed(Duration(seconds: 3));
    return Money.from(goldenDragons: 9, silverDeers: 53);
  }
}
