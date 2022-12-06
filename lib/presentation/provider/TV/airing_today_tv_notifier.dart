import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_airing_today.dart';
import 'package:flutter/material.dart';

class AiringTodayTVNotifier extends ChangeNotifier {
  final GetTVAiringToday getTVAiringTodays;

  AiringTodayTVNotifier({required this.getTVAiringTodays});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _airingTodayTV = [];
  List<TV> get airingTodayTV => _airingTodayTV;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVAiringTodays.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _airingTodayTV = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
