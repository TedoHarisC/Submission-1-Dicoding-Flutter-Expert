import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/TV/airing_today_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AiringTodayTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tv';
  const AiringTodayTVPage({super.key});

  @override
  State<AiringTodayTVPage> createState() => _AiringTodayTVPageState();
}

class _AiringTodayTVPageState extends State<AiringTodayTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AiringTodayTVNotifier>(context, listen: false)
            .fetchAiringTodayTVs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodayTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvOnTheAir = data.airingTodayTV[index];
                  return TVCard(tv: tvOnTheAir);
                },
                itemCount: data.airingTodayTV.length,
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
