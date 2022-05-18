part of 'shorten_bloc.dart';

abstract class ShortenEvent extends Equatable {
  const ShortenEvent();

  @override
  List<Object> get props => [];
}

class ShortenUrlEvent extends ShortenEvent {
  final String/*!*/ url;
  ShortenUrlEvent({this.url});
}
