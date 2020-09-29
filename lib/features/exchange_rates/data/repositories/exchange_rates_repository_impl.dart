import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:lufick_test/core/error/exceptions.dart';
import 'package:lufick_test/core/network/network_info.dart';
import 'package:lufick_test/features/exchange_rates/data/datasources/converted_exchange_rates_local_data_source.dart';
import 'package:lufick_test/features/exchange_rates/data/datasources/exchange_rates_remote_data_source.dart';
import 'package:lufick_test/features/exchange_rates/domain/entities/exchange.dart';
import 'package:lufick_test/features/exchange_rates/domain/repositories/exchange_rate_repository.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRatesRemoteDataSource exchangeRatesRemoteDataSource;
  final ConvertedExchangeRatesLocalDataSource
      convertedExchangeRatesLocalDataSource;
  final NetworkInfo networkInfo;

  ExchangeRateRepositoryImpl(
      {@required this.exchangeRatesRemoteDataSource,
      @required this.convertedExchangeRatesLocalDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, Exchange>> getExchangeRates() async {
    if (await networkInfo.isConnected) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
      try {
        networkInfo.isConnected;
        final exchangeRate =
            await exchangeRatesRemoteDataSource.getExchangeRatesData();
        await convertedExchangeRatesLocalDataSource
            .cacheRefreshDate(formattedDate);
        await convertedExchangeRatesLocalDataSource
            .cacheExchangeRates(exchangeRate);
        // print("Currency : " + exchangeRate.rates.elementAt(0).currency);
        return Right(exchangeRate);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Exchange>> getConvertedExchangeRates(
      int number) async {
    try {
      final localConvertedExchangeRate =
          await convertedExchangeRatesLocalDataSource
              .getConvertedExchangeRatesData(number);
      return Right(localConvertedExchangeRate);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getRefreshDate() async {
    try {
      final localRefreshDate =
          await convertedExchangeRatesLocalDataSource.getRefreshDate();
      return Right(localRefreshDate);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
