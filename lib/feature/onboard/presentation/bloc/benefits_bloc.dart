import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly/feature/onboard/domian/usecase/skip_benefits_use_case.dart';

part 'benefits_event.dart';

part 'benefits_state.dart';

@injectable
class BenefitsBloc extends Bloc<BenefitsEvent, BenefitsState> {
  final SkipBenefitsUseCase/*!*/ _skipBenefitsUseCase;

  BenefitsBloc(this._skipBenefitsUseCase) : super(BenefitsInitial());

  @override
  Stream<BenefitsState> mapEventToState(
    BenefitsEvent event,
  ) async* {
    if (event is SkipBenefitsEvent) {
      _skipBenefitsUseCase();
      yield BenefitsSkipped();
    }
  }

  skip() {
    add(SkipBenefitsEvent());
  }
}
