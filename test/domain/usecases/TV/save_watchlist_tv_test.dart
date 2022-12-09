import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/TV/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTVs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SaveWatchlistTVs(mockTVRepository);
  });

  test('should save TV to the repository', () async {
    // arrange
    when(mockTVRepository.saveWatchlistTV(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.saveWatchlistTV(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
