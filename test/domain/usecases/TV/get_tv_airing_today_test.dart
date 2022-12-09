import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_airing_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVAiringToday getTVAiringToday;
  late MockTVRepository mockTVRepository;
  setUp(() {
    mockTVRepository = MockTVRepository();
    getTVAiringToday = GetTVAiringToday(mockTVRepository);
  });

  final tvs = <TV>[];
  group('Get TV Series Airing Today', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      ///arrange
      when(mockTVRepository.getTVAiringToday())
          .thenAnswer((_) async => Right(tvs));

      ///act
      final result = await getTVAiringToday.execute();

      ///assert
      expect(result, Right(tvs));
    });
  });
}
