import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/feature/history/domain/usecase/delete_short_url_use_case.dart';
import 'package:shortly/feature/history/domain/usecase/get_short_url_history_use_case.dart';
import 'package:shortly/feature/shorten/domain/usecase/shorten_url_use_case.dart';

part 'short_url_history_state.dart';
part 'short_url_history_event.dart';

@injectable
class ShortUrlHistoryBloc
    extends Bloc<ShortUrlHistoryEvent, ShortUrlHistoryState> {
  final GetShortUrlHistoryUseCase/*!*/ _getShortUrlHistoryUseCase;
  final DeleteShortUrlUseCase/*!*/ _deleteShortUrlUseCase;

  ShortUrlHistoryBloc(
      this._getShortUrlHistoryUseCase, this._deleteShortUrlUseCase)
      : super(ShortUrlHistoryInitial());

  @override
  Stream<ShortUrlHistoryState> mapEventToState(
    ShortUrlHistoryEvent event,
  ) async* {
    if (event is LoadShortUrlHistoryEvent) {
      // yield ShortUrlHistoryLoading();
      final result = _getShortUrlHistoryUseCase();
      yield ShortUrlHistorySuccess(result);
    } else if (event is DeleteShortUrlEvent) {
      _deleteShortUrlUseCase(event.shortUrl);
    }
  }

  deleteShortUrl(ShortUrl shortUrl) {
    add(DeleteShortUrlEvent(shortUrl));
  }

  Stream<List<ShortUrl>>/*!*/ getHistoryListStream(){
    return _getShortUrlHistoryUseCase();
  }
}
