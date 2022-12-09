import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVTopRated usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVTopRated(mockTVRepository);
  });

  final tvs = <TV>[];

  test('should get list of TV Series from repository', () async {
    // arrange
    when(mockTVRepository.getTVTopRated()).thenAnswer((_) async => Right(tvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvs));
  });
}
