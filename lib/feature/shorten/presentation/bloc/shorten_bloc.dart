import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/data/model/short_url.dart';
import 'package:shortly/feature/shorten/domain/usecase/shorten_url_use_case.dart';

part 'shorten_event.dart';
part 'shorten_state.dart';


@injectable
class ShortenBloc extends Bloc<ShortenEvent, ShortenState> {
  final ShortenUrlUseCase _shortenUrlUseCase;
  ShortenBloc(this._shortenUrlUseCase) : super(ShortenInitial());

  @override
  Stream<ShortenState> mapEventToState(
    ShortenEvent event,
  ) async* {
    if (event is ShortenUrlEvent) {
      yield ShortenLoading();
      final Result<ShortUrl> result =
          await _shortenUrlUseCase(event.url);

      if(result is Success<ShortUrl>){
        yield ShortenSuccess(result.data);
      } else if(result is Error<ShortUrl>) {
        yield ShortenFailure(result.appException.msg);
      } else {
        throw Exception("invalid result");
      }
    }
  }

  shortenUrl(String url) {
    add(ShortenUrlEvent(url: url));
  }
}
