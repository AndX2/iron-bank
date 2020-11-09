import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/common/api_routes.dart';
import 'package:iron_bank/gateway/statement/balance_response.dart';

@injectable
@prod
class StatementRepository {
  final Dio _client;

  StatementRepository(this._client);

  Future<Money> fetchBalance() {
    return _client
        .get(ApiRoutes.statement)
        .then((response) => BalanceResponse.fromJson(response.data).parse());
  }
}
