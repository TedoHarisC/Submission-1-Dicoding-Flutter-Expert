import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_top_rated.dart';
import 'package:ditonton/presentation/provider/TV/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTVAiringToday, GetTVPopular, GetTVTopRated, GetTVOnTheAir])
void main() {
  late TVListNotifier provider;
  late MockGetTVAiringToday mockGetTVAiringToday;
  late MockGetTVPopular mockGetTVPopular;
  late MockGetTVTopRated mockGetTVTopRated;
  late MockGetTVOnTheAir mockGetTVOnTheAir;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVAiringToday = MockGetTVAiringToday();
    mockGetTVPopular = MockGetTVPopular();
    mockGetTVTopRated = MockGetTVTopRated();
    mockGetTVOnTheAir = MockGetTVOnTheAir();
    provider = TVListNotifier(
      getTVAiringTodays: mockGetTVAiringToday,
      getTVOnTheAirs: mockGetTVOnTheAir,
      getTVPopulars: mockGetTVPopular,
      getTVTopRateds: mockGetTVTopRated,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('Airing Today TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTVAiringToday.execute()).thenAnswer((_) async => Right(tvs));
      // act
      provider.fetchTVAiringToday();
      // assert
      verify(mockGetTVAiringToday.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTVAiringToday.execute()).thenAnswer((_) async => Right(tvs));
      // act
      provider.fetchTVAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTVAiringToday.execute()).thenAnswer((_) async => Right(tvs));
      // act
      await provider.fetchTVAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.tvAiringToday, tvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVAiringToday.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTVPopular.execute()).thenAnswer((_) async => Right(tvs));
      // act
      provider.fetchTVPopular();
      // assert
      expect(provider.popularState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTVPopular.execute()).thenAnswer((_) async => Right(tvs));
      // act
      await provider.fetchTVPopular();
      // assert
      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularTV, tvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVPopular();
      // assert
      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTVTopRated.execute()).thenAnswer((_) async => Right(tvs));
      // act
      provider.fetchTVTopRated();
      // assert
      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTVTopRated.execute()).thenAnswer((_) async => Right(tvs));
      // act
      await provider.fetchTVTopRated();
      // assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTV, tvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVTopRated();
      // assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('On The Air tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTVOnTheAir.execute()).thenAnswer((_) async => Right(tvs));
      // act
      provider.fetchTVOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTVOnTheAir.execute()).thenAnswer((_) async => Right(tvs));
      // act
      await provider.fetchTVOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.tvOnTheAir, tvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
