import 'package:dartz/dartz.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/core/usecases/usecase.dart';
import 'package:lufick_test/features/exchange_rates/domain/entities/exchange.dart';
import 'package:lufick_test/features/exchange_rates/domain/repositories/exchange_rate_repository.dart';

class GetExchangeRates implements UseCase<Exchange, NoParams> {
  ExchangeRateRepository repository;

  GetExchangeRates(this.repository);
  @override
  Future<Either<Failure, Exchange>> call(NoParams params) async {
    return await repository.getExchangeRates();
  }
}
