part of 'short_url_history_bloc.dart';

abstract class ShortUrlHistoryState extends Equatable {
  const ShortUrlHistoryState();
  
  @override
  List<Object> get props => [];
}

class ShortUrlHistoryInitial extends ShortUrlHistoryState {}
class ShortUrlHistoryLoading extends ShortUrlHistoryState {}
class ShortUrlHistorySuccess extends ShortUrlHistoryState {
  final Stream<List<ShortUrl>>? shortUrlStream;

  ShortUrlHistorySuccess(this.shortUrlStream);
}
// class ShortUrlHistoryFailure extends ShortUrlHistoryState {
//  final String msg;
//
//   ShortUrlHistoryFailure(this.msg);
// }