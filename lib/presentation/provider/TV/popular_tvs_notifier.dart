import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_popular.dart';
import 'package:flutter/material.dart';

class PopularTVsNotifier extends ChangeNotifier {
  final GetTVPopular getTVPopular;

  PopularTVsNotifier(this.getTVPopular);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _popularTV = [];
  List<TV> get popularTV => _popularTV;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVPopular.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _popularTV = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
