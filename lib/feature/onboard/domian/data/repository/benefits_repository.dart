import 'package:injectable/injectable.dart';
import 'package:shortly/feature/onboard/domian/data/source/benefits_local_data_source.dart';

abstract class BenefitsRepository {
  Future<void> skip();

  bool isSkipped();
}

@Singleton(as: BenefitsRepository)
class BenefitsRepositoryImpl extends BenefitsRepository {
  final BenefitsLocalDataSource/*!*/ _benefitsLocalDataSource;

  BenefitsRepositoryImpl(this._benefitsLocalDataSource);

  @override
  Future<void> skip() => _benefitsLocalDataSource.skip();

  @override
  bool isSkipped() => _benefitsLocalDataSource.isSkipped();
}
