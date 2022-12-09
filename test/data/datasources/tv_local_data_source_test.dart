import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSourceTV;
  late MockDatabaseHelperTV mockDatabaseHelperTV;

  setUp(() {
    mockDatabaseHelperTV = MockDatabaseHelperTV();
    dataSourceTV =
        TVLocalDataSourceImpl(databaseHelperTV: mockDatabaseHelperTV);
  });

  group('save watchlist TV', () {
    test('should return success message wen insert to database is successful',
        () async {
      /// arrange
      when(mockDatabaseHelperTV.insertWatchlistTV(testTVTable))
          .thenAnswer((_) async => 1);

      /// act
      final result = await dataSourceTV.insertWatchlistTV(testTVTable);

      /// assert
      expect(result, 'Added to Watchlist TV Series');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTV.insertWatchlistTV(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTV.insertWatchlistTV(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist TV', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTV.removeWatchlistTV(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceTV.removeWatchlistTV(testTVTable);
      // assert
      expect(result, 'Removed from Watchlist TV Series');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTV.removeWatchlistTV(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTV.removeWatchlistTV(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    final tvId = 1;

    test('should return Tv Detail Table when data is found', () async {
      ///arrange
      when(mockDatabaseHelperTV.getTVById(tvId))
          .thenAnswer((_) async => testTVMap);

      ///act
      final result = await dataSourceTV.getTVById(tvId);

      ///assert
      expect(result, testTVTable);
    });

    test('should return null when data is not found', () async {
      ///arrange
      when(mockDatabaseHelperTV.getTVById(tvId)).thenAnswer((_) async => null);

      ///act
      final result = await dataSourceTV.getTVById(tvId);

      ///assert
      expect(result, null);
    });
  });

  group('get watchlist TVs', () {
    test('should return list of TVTable from database', () async {
      // arrange
      when(mockDatabaseHelperTV.getWatchlistTV())
          .thenAnswer((_) async => [testTVMap]);
      // act
      final result = await dataSourceTV.getWatchlistTVs();
      // assert
      expect(result, [testTVTable]);
    });
  });
}
