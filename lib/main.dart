import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/TV/airing_today_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/detail_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/home_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/on_the_air_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/search_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/TV/airing_today_tv_notifier.dart';
import 'package:ditonton/presentation/provider/TV/on_the_air_tv_notifier.dart';
import 'package:ditonton/presentation/provider/TV/popular_tvs_notifier.dart';
import 'package:ditonton/presentation/provider/TV/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/TV/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/TV/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/TV/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTVsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringTodayTVNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeTVPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTVPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case AiringTodayTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AiringTodayTVPage());
            case OnTheAirTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => OnTheAirTVPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case DetailTVPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTVPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
