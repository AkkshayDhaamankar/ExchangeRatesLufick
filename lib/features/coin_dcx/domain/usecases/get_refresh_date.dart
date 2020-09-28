import 'package:dartz/dartz.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/core/usecases/usecase.dart';
import 'package:lufick_test/features/coin_dcx/domain/repositories/exchange_rate_repository.dart';

class GetRefreshDateUseCase implements UseCase<String, NoParams> {
  ExchangeRateRepository repository;

  GetRefreshDateUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getRefreshDate();
  }
}
