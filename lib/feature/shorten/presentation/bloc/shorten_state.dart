part of 'shorten_bloc.dart';

abstract class ShortenState extends Equatable {
  const ShortenState();
  
  @override
  List<Object> get props => [];
}

class ShortenInitial extends ShortenState {}
class ShortenLoading extends ShortenState {}
class ShortenSuccess extends ShortenState {
  final ShortUrl shortUrl;

  ShortenSuccess(this.shortUrl);
}
class ShortenFailure extends ShortenState {
 final String msg;
  final AppException appException;

  ShortenFailure(this.msg, this.appException);
}