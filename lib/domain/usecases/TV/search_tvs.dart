import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class SearchTVs {
  final TVRepository tvRepository;

  SearchTVs(this.tvRepository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return tvRepository.searchTVs(query);
  }
}
