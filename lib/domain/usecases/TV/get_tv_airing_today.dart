import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVAiringToday {
  final TVRepository tvRepository;

  GetTVAiringToday(this.tvRepository);

  Future<Either<Failure, List<TV>>> execute() {
    return tvRepository.getTVAiringToday();
  }
}
