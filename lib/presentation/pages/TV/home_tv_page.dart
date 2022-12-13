import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/TV/airing_today_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/detail_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/on_the_air_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/search_tv_page.dart';
import 'package:ditonton/presentation/pages/TV/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/provider/TV/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_home';

  const HomeTVPage({super.key});

  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => Provider.of<TVListNotifier>(context, listen: false)
      ..fetchTVPopular()
      ..fetchTVAiringToday()
      ..fetchTVTopRated()
      ..fetchTVOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton TV Series'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('TV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton for TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TV Top Rated',
                style: kHeading6,
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.topRatedState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.topRatedTV);
                } else {
                  return Text('Failed to show TV Top Rated Series');
                }
              }),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.popularTV);
                } else {
                  return Text('Failed to show Popular TV Series');
                }
              }),
              _buildSubHeading(
                title: 'TV Airing Today',
                onTap: () =>
                    Navigator.pushNamed(context, AiringTodayTVPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.tvAiringToday);
                } else {
                  return Text('Failed to show TV Airing Today');
                }
              }),
              _buildSubHeading(
                title: 'TV On The Air',
                onTap: () =>
                    Navigator.pushNamed(context, OnTheAirTVPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.onTheAirState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.tvOnTheAir);
                } else {
                  return Text('Failed to show TV On The Air Today');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tvs;

  TVList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailTVPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
