import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvModel = TVModel(
      backdropPath: "backdropPath",
      genreIds: [18],
      id: 11250,
      name: "Name",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "Toverview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1);
  final tv = TV(
      backdropPath: "backdropPath",
      genreIds: [18],
      id: 11250,
      name: "Name",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "Toverview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1);

  test('should be a subclass of TV Series entity', () async {
    final result = tvModel.toEntity();
    expect(result, tv);
  });
}
