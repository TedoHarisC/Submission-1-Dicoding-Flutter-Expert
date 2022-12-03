import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TVRepositoryImpl implements TVRepository {
  final TVRemoteDataSource tvRemoteDataSource;
  final NetworkInfo networkInfo;
  final TVLocalDataSource tvLocalDataSource;

  TVRepositoryImpl({
    required this.tvRemoteDataSource,
    required this.tvLocalDataSource,
    required this.networkInfo,
  });

  //LOCAL
  @override
  Future<Either<Failure, String>> saveWatchlistTV(TVDetail tvDetail) async {
    try {
      final result = await tvLocalDataSource
          .insertWatchlistTV(TVTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTV(TVDetail tvDetail) async {
    try {
      final result = await tvLocalDataSource
          .removeWatchlistTV(TVTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlistTV(int id) async {
    final result = await tvLocalDataSource.getTVById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TV>>> getWatchlistTVs() async {
    final result = await tvLocalDataSource.getWatchlistTVs();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  // REMOTE
  @override
  Future<Either<Failure, TVDetail>> getTVDetail(int id) async {
    try {
      final result = await tvRemoteDataSource.getDetailTV(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id) async {
    try {
      final result = await tvRemoteDataSource.getTVRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> searchTVs(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTV(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTVAiringToday() async {
    try {
      final result = await tvRemoteDataSource.getTVAiringToday();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTVOnTheAir() async {
    try {
      final result = await tvRemoteDataSource.getTVOnTheAir();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTVPopular() async {
    try {
      final result = await tvRemoteDataSource.getTVPopular();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTVTopRated() async {
    try {
      final result = await tvRemoteDataSource.getTVTopRated();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }
}
