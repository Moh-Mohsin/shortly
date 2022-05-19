import 'package:injectable/injectable.dart';
import 'package:shortly/feature/onboard/domian/data/repository/benefits_repository.dart';

@injectable
class IsBenefitsSkippedUseCase {
  final BenefitsRepository _benefitsRepository;

  IsBenefitsSkippedUseCase(this._benefitsRepository);

  bool call() => _benefitsRepository.isSkipped();
}
