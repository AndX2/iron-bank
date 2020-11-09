import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/error/winter_has_come_exception.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/scoring/scoring_repository.dart';
import 'package:iron_bank/service/statement_service.dart';
import 'package:iron_bank/service/winter_service.dart';

/// Сервис расчета доступного кредита
@singleton
class ScoringService {
  final ScoringRepository _scoringRepository;
  final WinterService _winterService;

  ScoringService(
    this._scoringRepository,
    this._winterService,
  );

  Future<Money> getCreditLimit() async {
    final hasWinterCome = await _winterService.winterIsHere();
    if (hasWinterCome) {
      throw WinterHasComeException();
    }
    return _scoringRepository.fetchCreditData();
  }
}
