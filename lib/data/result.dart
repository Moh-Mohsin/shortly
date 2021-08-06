
import 'package:equatable/equatable.dart';
import 'package:shortly/data/exceptions/exceptions.dart';

abstract class Result<T> extends Equatable {
  const Result();

  @override
  List<Object> get props => [];
}

class Success<T> extends Result<T>{
  final T data;

  Success(this.data);
}

class Error<T> extends Result<T>{
  final AppException appException;

  Error(this.appException);
}

// extension ResultMapping on Result{
//
// }