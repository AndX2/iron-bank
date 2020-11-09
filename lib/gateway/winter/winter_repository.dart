import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Репозиторий API местного гидрометцентра
@injectable
@prod
class WinterRepository {
  final Dio _client;

  WinterRepository(@Named("winter") this._client);

  Future<bool> winterIsHere() {
    return _client.get('').then((response) => response.data);
  }
}
