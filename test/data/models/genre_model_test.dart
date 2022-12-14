import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final genreModel = GenreModel(id: 1, name: 'name');
  final genre = Genre(id: 1, name: 'name');

  test('should be a subclass of genre entity for TV Series', () async {
    final result = genreModel.toEntity();
    expect(result, genre);
  });
}
