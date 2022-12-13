import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_popular.dart';
import 'package:ditonton/presentation/provider/TV/popular_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_notifier_test.mocks.dart';

@GenerateMocks([GetTVPopular])
void main() {
  late MockGetTVPopular mockGetTVPopular;
  late PopularTVsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVPopular = MockGetTVPopular();
    notifier = PopularTVsNotifier(mockGetTVPopular)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tv = TV(
      backdropPath: "backdropPath",
      genreIds: [1, 2, 3],
      id: 1,
      name: "name",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);
  final tvs = <TV>[tv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTVPopular.execute()).thenAnswer((_) async => Right(tvs));
    // act
    notifier.fetchPopularTVs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTVPopular.execute()).thenAnswer((_) async => Right(tvs));
    // act
    await notifier.fetchPopularTVs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.popularTV, tvs);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTVPopular.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTVs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
