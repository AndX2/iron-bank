import 'package:injectable/injectable.dart';
import 'package:iron_bank/gateway/winter/winter_repository.dart';

/// Сервис местного гидрометцентра
@singleton
class WinterService {
  final WinterRepository _winterRepository;

  WinterService(this._winterRepository);

  Future<bool> winterIsHere() => _winterRepository.winterIsHere();
}
