import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  final GetTVAiringToday getTVAiringTodays;
  final GetTVOnTheAir getTVOnTheAirs;
  final GetTVPopular getTVPopulars;
  final GetTVTopRated getTVTopRateds;

  // TV Series Airing Today
  var _tvAiringToday = <TV>[];
  List<TV> get tvAiringToday => _tvAiringToday;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  // TV Series TV ON THE AIR
  var _tvOnTheAir = <TV>[];
  List<TV> get tvOnTheAir => _tvOnTheAir;

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirState;

  // TV SERIES POPULAR
  var _popularTV = <TV>[];
  List<TV> get popularTV => _popularTV;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  // TV Series Top Rated
  var _topRatedTV = <TV>[];
  List<TV> get topRatedTV => _topRatedTV;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getTVAiringTodays,
    required this.getTVOnTheAirs,
    required this.getTVPopulars,
    required this.getTVTopRateds,
  });

  Future<void> fetchTVAiringToday() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getTVAiringTodays.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _airingTodayState = RequestState.Loaded;
        _tvAiringToday = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVOnTheAir() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTVOnTheAirs.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _onTheAirState = RequestState.Loaded;
        _tvOnTheAir = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVPopular() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getTVPopulars.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularState = RequestState.Loaded;
        _popularTV = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVTopRated() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTVTopRateds.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTV = tvsData;
        notifyListeners();
      },
    );
  }
}
