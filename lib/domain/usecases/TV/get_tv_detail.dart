import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVDetail {
  final TVRepository tvRepository;

  GetTVDetail(this.tvRepository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return tvRepository.getTVDetail(id);
  }
}
