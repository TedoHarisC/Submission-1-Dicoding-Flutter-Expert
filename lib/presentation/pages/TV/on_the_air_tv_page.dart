import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/TV/on_the_air_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv';
  const OnTheAirTVPage({super.key});

  @override
  State<OnTheAirTVPage> createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTVNotifier>(context, listen: false)
            .fetchOnTheAirTVs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvOnTheAir = data.onTheAirTV[index];
                  return TVCard(tv: tvOnTheAir);
                },
                itemCount: data.onTheAirTV.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
