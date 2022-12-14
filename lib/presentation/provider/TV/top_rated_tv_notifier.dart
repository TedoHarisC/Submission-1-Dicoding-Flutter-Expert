import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TopRatedTVNotifier extends ChangeNotifier {
  final GetTVTopRated getTopRatedTV;

  TopRatedTVNotifier({required this.getTopRatedTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tvs = [];
  List<TV> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tvs = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
