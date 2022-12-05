import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_watchlist_tvs.dart';
import 'package:flutter/material.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTVs = <TV>[];
  List<TV> get watchlistTVs => _watchlistTVs;

  var _watchlistTVState = RequestState.Empty;
  RequestState get watchlistTVState => _watchlistTVState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTVs getWatchlistTVs;
  WatchlistTVNotifier({required this.getWatchlistTVs});

  Future<void> fetchWatchlistTVs() async {
    _watchlistTVState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVs.execute();
    result.fold(
      (failure) {
        _watchlistTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _watchlistTVState = RequestState.Loaded;
        _watchlistTVs = tvsData;
        notifyListeners();
      },
    );
  }
}
