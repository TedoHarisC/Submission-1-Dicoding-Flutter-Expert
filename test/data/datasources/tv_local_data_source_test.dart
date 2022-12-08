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
    // test('should return success message when insert to database is success',
    //     () async {
    //   // arrange
    //   when(mockDatabaseHelperTV.insertWatchlistTV(testTVTable))
    //       .thenAnswer((_) async => 1);
    //   // act
    //   final result = await dataSourceTV.insertWatchlistTV(testTVTable);
    //   // assert
    //   expect(result, 'Added to Watchlist');
    // });

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
}
