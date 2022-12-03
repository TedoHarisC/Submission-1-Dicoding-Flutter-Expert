import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../entities/tv/tv_detail.dart';

class RemoveWatchlistTV {
  final TVRepository tvRepository;

  RemoveWatchlistTV(this.tvRepository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return tvRepository.removeWatchlistTV(tv);
  }
}
