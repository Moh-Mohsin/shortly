import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/domain/usecase/shorten_url_use_case.dart';

part 'shorten_event.dart';
part 'shorten_state.dart';

@injectable
class ShortenBloc extends Bloc<ShortenEvent, ShortenState> {
  final ShortenUrlUseCase _shortenUrlUseCase;
  ShortenBloc(this._shortenUrlUseCase) : super(ShortenInitial()) {
    on<ShortenUrlEvent>(_handleShortenUrl);
  }

  _handleShortenUrl(ShortenUrlEvent event, Emitter<ShortenState> emit) async {
    emit(ShortenLoading());
    final Result<ShortUrl>? result = await _shortenUrlUseCase(event.url);

    if (result is Success<ShortUrl>) {
      emit(ShortenSuccess(result.data));
    } else if (result is Error<ShortUrl>) {
      emit(ShortenFailure(result.appException.msg, result.appException));
    } else {
      throw Exception("invalid result");
    }
  } 

  shortenUrl(String url) {
    add(ShortenUrlEvent(url: url));
  }

  @override
  void onTransition(Transition<ShortenEvent, ShortenState> transition) {
    super.onTransition(transition);
    print(
        "transition from ${transition.currentState} to ${transition.nextState}");
  }
}
