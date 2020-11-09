import 'package:injectable/injectable.dart';
import 'package:iron_bank/gateway/scoring/scoring_repository.dart';
import 'package:iron_bank/gateway/winter/winter_repository.dart';

@Injectable(as: WinterRepository, env: [Environment.dev])
class WinterRepositoryMock implements WinterRepository {
  @override
  Future<bool> winterIsHere() {
    return Future.delayed(
      Duration(seconds: 3),
      () => false,
    );
  }
}
