import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/gateway/common/api_routes.dart';
import 'package:iron_bank/gateway/statement/balance_response.dart';

@injectable
@prod
class ScoringRepository {
  final Dio _client;

  ScoringRepository(this._client);

  Future<Money> fetchCreditData() {
    return _client
        .get(ApiRoutes.scoring)
        .then((response) => BalanceResponse.fromJson(response.data).parse());
  }
}
