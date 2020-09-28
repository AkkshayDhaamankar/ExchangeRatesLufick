import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lufick_test/core/usecases/usecase.dart';
import 'package:lufick_test/features/coin_dcx/domain/entities/exchange.dart';
import 'package:lufick_test/features/coin_dcx/domain/repositories/exchange_rate_repository.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_exchange_rates.dart';
import 'package:mockito/mockito.dart';

class MockExchangeRateRespository extends Mock
    implements ExchangeRateRepository {}

void main() {
  GetExchangeRates usecase;
  MockExchangeRateRespository mockExchangeRateRespository;
  setUp(() {
    mockExchangeRateRespository = MockExchangeRateRespository();
    usecase = GetExchangeRates(mockExchangeRateRespository);
  });

  List<Rates> tRatesList = [
    Rates(currency: "CAD", value: 1.556),
    Rates(currency: "RUB", value: 90.405),
    Rates(currency: "MXN", value: 26.0006),
  ];
  final Exchange tExchange =
      Exchange(rates: tRatesList, base: "EUR", date: "2020-09-25");

  test('should get exchange rates data', () async {
    //arrange
    when(mockExchangeRateRespository.getExchangeRates())
        .thenAnswer((_) async => Right(tExchange));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, Right(tExchange));
    verify(mockExchangeRateRespository.getExchangeRates());
    verifyNoMoreInteractions(mockExchangeRateRespository);
  });
}
