part of 'benefits_bloc.dart';

abstract class BenefitsState extends Equatable {
  const BenefitsState();

  @override
  List<Object> get props => [];
}

class BenefitsInitial extends BenefitsState {}

class BenefitsSkipped extends BenefitsState {}
