import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper_tv.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/TV/get_tv_top_rated.dart';
import 'package:ditonton/domain/usecases/TV/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/TV/get_watchlist_tvs.dart';
import 'package:ditonton/domain/usecases/TV/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/TV/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/TV/search_tvs.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/provider/TV/airing_today_tv_notifier.dart';
import 'package:ditonton/presentation/provider/TV/on_the_air_tv_notifier.dart';
import 'package:ditonton/presentation/provider/TV/popular_tvs_notifier.dart';
import 'package:ditonton/presentation/provider/TV/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/TV/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/TV/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TVListNotifier(
      getTVAiringTodays: locator(),
      getTVPopulars: locator(),
      getTVOnTheAirs: locator(),
      getTVTopRateds: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => TVDetailNotifier(
      getTVDetail: locator(),
      getTVRecommendations: locator(),
      getWatchListStatusTV: locator(),
      saveWatchlistTV: locator(),
      removeWatchlistTV: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TVSearchNotifier(
      searchTVs: locator(),
    ),
  );

  // Movies Section
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // TVs Section
  locator.registerFactory(
    () => PopularTVsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => AiringTodayTVNotifier(
      getTVAiringTodays: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTVNotifier(
      getTVOnTheAir: locator(),
    ),
  );

  // use case (MOVIE)
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case (TV)
  locator.registerLazySingleton(() => GetTVAiringToday(locator()));
  locator.registerLazySingleton(() => GetTVOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVPopular(locator()));
  locator.registerLazySingleton(() => GetTVTopRated(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVs(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVs(locator()));

  // repository (MOVIE)
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository (TV)
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      tvRemoteDataSource: locator(),
      tvLocalDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelperTV: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTV>(() => DatabaseHelperTV());

  // network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
