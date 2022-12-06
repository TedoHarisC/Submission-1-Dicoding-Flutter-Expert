import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_on_the_air.dart';
import 'package:flutter/material.dart';

class OnTheAirTVNotifier extends ChangeNotifier {
  final GetTVOnTheAir getTVOnTheAir;

  OnTheAirTVNotifier({required this.getTVOnTheAir});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _onTheAirTV = [];
  List<TV> get onTheAirTV => _onTheAirTV;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVOnTheAir.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _onTheAirTV = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
