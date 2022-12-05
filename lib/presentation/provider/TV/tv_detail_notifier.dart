import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/TV/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/TV/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/TV/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

class TVDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatusTV;
  final SaveWatchlistTVs saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  TVDetailNotifier({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatusTV,
    required this.saveWatchlistTV,
    required this.removeWatchlistTV,
  });

  late TVDetail _tvDetail;
  TVDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  List<TV> _tvRecommendations = [];
  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _tvRecommendationState = RequestState.Empty;
  RequestState get tvRecommendationState => _tvRecommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTV = false;
  bool get isAddedToWatchlistTV => _isAddedtoWatchlistTV;

  Future<void> fetchTVDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvDetailData) {
        _tvRecommendationState = RequestState.Loading;
        _tvDetail = tvDetailData;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _tvRecommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvs) {
            _tvRecommendationState = RequestState.Loaded;
            _tvRecommendations = tvs;
          },
        );
      },
    );
  }

  String _watchlistMessageTV = '';
  String get watchlistMessageTV => _watchlistMessageTV;

  Future<void> addWatchlist(TVDetail tvDetail) async {
    final result = await saveWatchlistTV.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessageTV = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTV = successMessage;
      },
    );

    await loadWatchlistStatusTV(tvDetail.id);
  }

  Future<void> removeFromWatchlistTV(TVDetail tvDetail) async {
    final result = await removeWatchlistTV.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessageTV = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTV = successMessage;
      },
    );

    await loadWatchlistStatusTV(tvDetail.id);
  }

  Future<void> loadWatchlistStatusTV(int id) async {
    final result = await getWatchListStatusTV.execute(id);
    _isAddedtoWatchlistTV = result;
    notifyListeners();
  }
}
