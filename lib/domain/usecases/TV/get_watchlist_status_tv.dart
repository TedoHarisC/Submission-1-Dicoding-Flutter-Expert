import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchListStatusTV {
  final TVRepository tvRepository;

  GetWatchListStatusTV(this.tvRepository);

  Future<bool> execute(int id) async {
    return tvRepository.isAddedToWatchlistTV(id);
  }
}
