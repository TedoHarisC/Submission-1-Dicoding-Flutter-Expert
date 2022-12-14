// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/TV/tv_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv/tv.dart' as _i10;
import 'package:ditonton/domain/entities/tv/tv_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/TV/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/TV/get_tv_recommendations.dart' as _i3;
import 'package:ditonton/domain/usecases/TV/get_watchlist_status_tv.dart'
    as _i4;
import 'package:ditonton/domain/usecases/TV/remove_watchlist_tv.dart' as _i6;
import 'package:ditonton/domain/usecases/TV/save_watchlist_tv.dart' as _i5;
import 'package:ditonton/presentation/provider/TV/tv_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTVDetail_0 extends _i1.SmartFake implements _i2.GetTVDetail {
  _FakeGetTVDetail_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetTVRecommendations_1 extends _i1.SmartFake
    implements _i3.GetTVRecommendations {
  _FakeGetTVRecommendations_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListStatusTV_2 extends _i1.SmartFake
    implements _i4.GetWatchListStatusTV {
  _FakeGetWatchListStatusTV_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveWatchlistTVs_3 extends _i1.SmartFake
    implements _i5.SaveWatchlistTVs {
  _FakeSaveWatchlistTVs_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveWatchlistTV_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlistTV {
  _FakeRemoveWatchlistTV_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTVDetail_5 extends _i1.SmartFake implements _i7.TVDetail {
  _FakeTVDetail_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TVDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVDetailNotifier extends _i1.Mock implements _i8.TVDetailNotifier {
  MockTVDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTVDetail get getTVDetail =>
      (super.noSuchMethod(Invocation.getter(#getTVDetail),
              returnValue:
                  _FakeGetTVDetail_0(this, Invocation.getter(#getTVDetail)))
          as _i2.GetTVDetail);
  @override
  _i3.GetTVRecommendations get getTVRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getTVRecommendations),
              returnValue: _FakeGetTVRecommendations_1(
                  this, Invocation.getter(#getTVRecommendations)))
          as _i3.GetTVRecommendations);
  @override
  _i4.GetWatchListStatusTV get getWatchListStatusTV =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatusTV),
              returnValue: _FakeGetWatchListStatusTV_2(
                  this, Invocation.getter(#getWatchListStatusTV)))
          as _i4.GetWatchListStatusTV);
  @override
  _i5.SaveWatchlistTVs get saveWatchlistTV => (super.noSuchMethod(
      Invocation.getter(#saveWatchlistTV),
      returnValue: _FakeSaveWatchlistTVs_3(
          this, Invocation.getter(#saveWatchlistTV))) as _i5.SaveWatchlistTVs);
  @override
  _i6.RemoveWatchlistTV get removeWatchlistTV =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlistTV),
              returnValue: _FakeRemoveWatchlistTV_4(
                  this, Invocation.getter(#removeWatchlistTV)))
          as _i6.RemoveWatchlistTV);
  @override
  _i7.TVDetail get tvDetail => (super.noSuchMethod(Invocation.getter(#tvDetail),
          returnValue: _FakeTVDetail_5(this, Invocation.getter(#tvDetail)))
      as _i7.TVDetail);
  @override
  _i9.RequestState get tvDetailState =>
      (super.noSuchMethod(Invocation.getter(#tvDetailState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  List<_i10.TV> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendations),
          returnValue: <_i10.TV>[]) as List<_i10.TV>);
  @override
  _i9.RequestState get tvRecommendationState =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendationState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlistTV =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlistTV),
          returnValue: false) as bool);
  @override
  String get watchlistMessageTV => (super
          .noSuchMethod(Invocation.getter(#watchlistMessageTV), returnValue: '')
      as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchTVDetail, [id]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlist(_i7.TVDetail? tvDetail) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [tvDetail]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlistTV(_i7.TVDetail? tvDetail) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlistTV, [tvDetail]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatusTV(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatusTV, [id]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}