import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/statement/statement_repository.dart';
import 'package:iron_bank/service/scoring_service.dart';
import 'package:rxdart/rxdart.dart';

/// Сервис баланса и выписок банка
@singleton
class StatementService {
  final StatementRepository _statementRepository;

  StatementService(
    this._statementRepository,
  );

  // ignore: close_sinks
  final balanceObservable = BehaviorSubject<Money>();

  void refreshBalance() async {
    final balance = await _statementRepository
        .fetchBalance()
        .catchError((error) => balanceObservable.addError(error));
    if (balance != null) balanceObservable.add(balance);
  }
}
