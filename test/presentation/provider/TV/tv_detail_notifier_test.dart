import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/TV/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/TV/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/TV/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/TV/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetWatchListStatusTV,
  SaveWatchlistTVs,
  RemoveWatchlistTV,
])
void main() {
  late TVDetailNotifier provider;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatusTV mockGetWatchListStatusTV;
  late MockSaveWatchlistTVs mockSaveWatchlistTVs;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchListStatusTV = MockGetWatchListStatusTV();
    mockSaveWatchlistTVs = MockSaveWatchlistTVs();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    provider = TVDetailNotifier(
        getTVDetail: mockGetTVDetail,
        getWatchListStatusTV: mockGetWatchListStatusTV,
        removeWatchlistTV: mockRemoveWatchlistTV,
        saveWatchlistTV: mockSaveWatchlistTVs,
        getTVRecommendations: mockGetTVRecommendations)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tv = TV(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11255,
      name: "Pasión de Pasión",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión",
      overview:
          "The gavilanes lives are shattered by a murder charge against Eric and León.",
      popularity: 64551.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 8.6,
      voteCount: 2771);
  final tvs = <TV>[tv];

  void _arrangeUsecase() {
    when(mockGetTVDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tvs));
  }

  group('Get TV Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTVDetail.execute(tId));
      verify(mockGetTVRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test(
        'should change recommendation tv series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Loaded);
      expect(provider.tvRecommendations, tvs);
    });
  });

  group('Get TV Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTVRecommendations.execute(tId));
      expect(provider.tvRecommendations, tvs);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvRecommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tvs);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvRecommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListStatusTV.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusTV(1);
      // assert
      expect(provider.isAddedToWatchlistTV, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTVs.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      verify(mockSaveWatchlistTVs.execute(testTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTV(testTVDetail);
      // assert
      verify(mockRemoveWatchlistTV.execute(testTVDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTVs.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      verify(mockGetWatchListStatusTV.execute(testTVDetail.id));
      expect(provider.isAddedToWatchlistTV, true);
      expect(provider.watchlistMessageTV, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTVs.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      expect(provider.watchlistMessageTV, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tvs));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
