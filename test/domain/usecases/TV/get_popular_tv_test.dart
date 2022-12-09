import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVPopular usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVPopular(mockTVRepository);
  });

  final tvs = <TV>[];

  group('Get Popular TV Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRepository.getTVPopular())
            .thenAnswer((_) async => Right(tvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tvs));
      });
    });
  });
}
