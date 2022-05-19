import 'package:injectable/injectable.dart';
import 'package:shortly/feature/onboard/domian/data/repository/benefits_repository.dart';

@injectable
class SkipBenefitsUseCase {
  final BenefitsRepository _benefitsRepository;

  SkipBenefitsUseCase(this._benefitsRepository);

  Future<void> call() async {
    return _benefitsRepository.skip();
  }
}
