import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

abstract class TVRepository {
  //Local
  Future<Either<Failure, String>> saveWatchlistTV(TVDetail tvDetail);
  Future<Either<Failure, String>> removeWatchlistTV(TVDetail tvDetail);
  Future<bool> isAddedToWatchlistTV(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTVs();

  //Remote
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTVs(String query);

  Future<Either<Failure, List<TV>>> getTVAiringToday();
  Future<Either<Failure, List<TV>>> getTVOnTheAir();
  Future<Either<Failure, List<TV>>> getTVPopular();
  Future<Either<Failure, List<TV>>> getTVTopRated();
}
