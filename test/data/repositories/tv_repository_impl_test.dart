import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockTVRemoteDataSource;
  late MockTVLocalDataSource mockTVLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTVRemoteDataSource = MockTVRemoteDataSource();
    mockTVLocalDataSource = MockTVLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TVRepositoryImpl(
      tvRemoteDataSource: mockTVRemoteDataSource,
      tvLocalDataSource: mockTVLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  // BESUK : DIGANTI
  final tvModel = TVModel(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview:
          "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765);

  // BESUK : DIGANTI
  final tv = TV(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview:
          "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765);

  final tvModelList = <TVModel>[tvModel];
  final tvList = <TV>[tv];

  group('Save watchlist TV Series', () {
    test('should return success message when saving successful', () async {
      ///arrange
      when(mockTVLocalDataSource.insertWatchlistTV(testTVTable))
          .thenAnswer((_) async => "Added to watchlist");

      ///act
      final result = await repository.saveWatchlistTV(testTVDetail);

      ///assert
      expect(result, Right('Added to watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async {
      ///arrange
      when(mockTVLocalDataSource.insertWatchlistTV(testTVTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      ///act
      final result = await repository.saveWatchlistTV(testTVDetail);

      ///assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist Tv Series', () {
    test('should return success message when remove successful', () async {
      ///arrange
      when(mockTVLocalDataSource.removeWatchlistTV(testTVTable))
          .thenAnswer((_) async => "Removed from watchlist");

      ///act
      final result = await repository.removeWatchlistTV(testTVDetail);

      ///assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async {
      ///arrange
      when(mockTVLocalDataSource.removeWatchlistTV(testTVTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      ///act
      final result = await repository.removeWatchlistTV(testTVDetail);

      ///assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Remove watchlist status TV Series', () {
    test('should return watch status weather data is found', () async {
      ///arrange
      final tId = 1;
      when(mockTVLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);

      ///act
      final result = await repository.isAddedToWatchlistTV(tId);

      ///assert
      expect(result, false);
    });
  });

  group('Get watchlist TV Series', () {
    test('should return list of TV Series', () async {
      ///arrange
      when(mockTVLocalDataSource.getWatchlistTVs())
          .thenAnswer((_) async => [testTVTable]);

      ///act
      final result = await repository.getWatchlistTVs();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });

  group('Search TV Series', () {
    final tQuery = 'pasion';

    test('should return TV Series list when call to data source is success',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.searchTVs(tQuery);

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.searchTV(tQuery))
          .thenThrow(ServerException());

      ///act
      final result = await repository.searchTVs(tQuery);

      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Airing Today TV Series', () {
    test('should return TV Series list when call to data source is success',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVAiringToday())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getTVAiringToday();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVAiringToday())
          .thenThrow(ServerException());

      ///act
      final result = await repository.getTVAiringToday();

      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('On The Air TV Series', () {
    test('should return TV Series list when call to data source is success',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVOnTheAir())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getTVOnTheAir();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVOnTheAir()).thenThrow(ServerException());

      ///act
      final result = await repository.getTVOnTheAir();

      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Popular TV Series', () {
    test('should return TV Series list when call to data source is success',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVPopular())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getTVPopular();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVPopular()).thenThrow(ServerException());

      ///act
      final result = await repository.getTVPopular();

      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return TV Series list when call to data source is success',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVTopRated())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getTVTopRated();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTVRemoteDataSource.getTVTopRated()).thenThrow(ServerException());

      ///act
      final result = await repository.getTVTopRated();

      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });
}
