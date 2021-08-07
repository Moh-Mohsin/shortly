part of 'short_url_history_bloc.dart';

abstract class ShortUrlHistoryEvent extends Equatable {
  const ShortUrlHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadShortUrlHistoryEvent extends ShortUrlHistoryEvent {}
class DeleteShortUrlEvent extends ShortUrlHistoryEvent {
  final ShortUrl shortUrl;

  DeleteShortUrlEvent(this.shortUrl);
}
