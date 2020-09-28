import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lufick_test/core/usecases/usecase.dart';
import 'package:lufick_test/features/coin_dcx/domain/entities/exchange.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_exchange_rates.dart';
import 'package:lufick_test/features/coin_dcx/presentation/bloc/exchange_bloc_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetExhangeRatesData extends Mock implements GetExchangeRates {}

void main() {
  ExchangeBlocBloc bloc;
  MockGetExhangeRatesData mockGetExhangeRatesData;

  setUp(() {
    mockGetExhangeRatesData = MockGetExhangeRatesData();
    bloc = new ExchangeBlocBloc(
      getExchangeRates: mockGetExhangeRatesData,
    );
  });
  List<Rates> tRatesList = [
    Rates(currency: "CAD", value: 1.556),
    Rates(currency: "RUB", value: 90.405),
    Rates(currency: "MXN", value: 26.0006),
  ];
  final Exchange tExchange =
      Exchange(rates: tRatesList, base: "EUR", date: "2020-09-25");
  void functionToCallExchangeRatesData() {
    when(mockGetExhangeRatesData.call(NoParams()))
        .thenAnswer((_) async => Right(tExchange));
  }

  group('GetExchangeRates', () {
    test('should get data from exchange rates use case', () async {
      //arrange
      functionToCallExchangeRatesData();
      // act
      bloc.add(GetDataForExchangeRates());
      await untilCalled(mockGetExhangeRatesData.call(NoParams()));
      // assert
      verify(mockGetExhangeRatesData.call(NoParams()));
    });

    test(
        'For Exchange Rates, should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      functionToCallExchangeRatesData();
      // assert later
      final expectedState = [
        LoadingExchange(),
        LoadedExchangeRates(exchange: tExchange),
      ];
      expectLater(bloc, emitsInOrder(expectedState));
      // act
      bloc.add(GetDataForExchangeRates());
    });
  });
}
