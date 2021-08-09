part of 'benefits_bloc.dart';

abstract class BenefitsEvent extends Equatable {
  const BenefitsEvent();

  @override
  List<Object> get props => [];
}

class SkipBenefitsEvent extends BenefitsEvent {}
