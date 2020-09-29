import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/exchange.dart';

abstract class ExchangeRateRepository {
  Future<Either<Failure, Exchange>> getExchangeRates();
  Future<Either<Failure, String>> getRefreshDate();
  Future<Either<Failure, Exchange>> getConvertedExchangeRates(int number);
}
