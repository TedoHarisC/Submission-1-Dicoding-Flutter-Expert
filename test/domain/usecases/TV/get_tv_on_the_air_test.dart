import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_on_the_air.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVOnTheAir getTVOnTheAir;
  late MockTVRepository mockTVRepository;
  setUp(() {
    mockTVRepository = MockTVRepository();
    getTVOnTheAir = GetTVOnTheAir(mockTVRepository);
  });

  final tv = <TV>[];
  group('Get On The Air TV Series', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      ///arrange
      when(mockTVRepository.getTVOnTheAir()).thenAnswer((_) async => Right(tv));

      ///act
      final result = await getTVOnTheAir.execute();

      ///assert
      expect(result, Right(tv));
    });
  });
}
