import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class SaveWatchlistTVs {
  final TVRepository tvRepository;

  SaveWatchlistTVs(this.tvRepository);

  Future<Either<Failure, String>> execute(TVDetail tvDetail) {
    return tvRepository.saveWatchlistTV(tvDetail);
  }
}
