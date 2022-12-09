import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTVs(mockTVRepository);
  });

  final tvs = <TV>[];
  final tQuery = 'The DAcademy Show';

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTVRepository.searchTVs(tQuery))
        .thenAnswer((_) async => Right(tvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tvs));
  });
}
