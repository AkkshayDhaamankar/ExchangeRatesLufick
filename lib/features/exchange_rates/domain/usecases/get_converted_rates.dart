import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lufick_test/features/exchange_rates/domain/entities/exchange.dart';
import 'package:lufick_test/features/exchange_rates/domain/repositories/exchange_rate_repository.dart';
import 'package:meta/meta.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/core/usecases/usecase.dart';

class GetConvertedRates implements UseCase<Exchange, Params> {
  ExchangeRateRepository repository;

  GetConvertedRates(this.repository);
  @override
  Future<Either<Failure, Exchange>> call(Params params) async {
    return await repository.getConvertedExchangeRates(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
