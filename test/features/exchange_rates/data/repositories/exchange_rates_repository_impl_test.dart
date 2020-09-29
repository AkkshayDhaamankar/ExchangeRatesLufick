import 'package:dartz/dartz.dart';
import 'package:lufick_test/core/error/exceptions.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/core/network/network_info.dart';
import 'package:lufick_test/features/exchange_rates/data/datasources/converted_exchange_rates_local_data_source.dart';
import 'package:lufick_test/features/exchange_rates/data/datasources/exchange_rates_remote_data_source.dart';
import 'package:lufick_test/features/exchange_rates/data/models/exhange_model.dart';
import 'package:lufick_test/features/exchange_rates/data/repositories/exchange_rates_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock
    implements ExchangeRatesRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements ConvertedExchangeRatesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ExchangeRateRepositoryImpl repository;
  MockNetworkInfo mockNetworkInfo;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDataSource = MockLocalDataSource();
    repository = ExchangeRateRepositoryImpl(
        exchangeRatesRemoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo,
        convertedExchangeRatesLocalDataSource: mockLocalDataSource);
  });

  void runTestsForExchangeRates(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  runTestsForExchangeRates(() {
    List<RatesModel> tRatesList = [
      RatesModel(currency: "CAD", value: 1.556),
      RatesModel(currency: "RUB", value: 90.405),
      RatesModel(currency: "MXN", value: 26.0006),
    ];
    final ExchangeModel tExchange =
        ExchangeModel(rates: tRatesList, base: "EUR", date: "2020-09-25");

    test('For ExchangeRate should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getExchangeRates();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test(
        'should return exchange rate remote data when the call to exchange rate data source is successful',
        () async {
      //arrange
      when(mockRemoteDataSource.getExchangeRatesData())
          .thenAnswer((_) async => tExchange);
      // act
      final result = await repository.getExchangeRates();
      // assert
      verify(mockRemoteDataSource.getExchangeRatesData());
      expect(result, equals(Right(tExchange)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRemoteDataSource.getExchangeRatesData())
          .thenThrow(ServerException());
      // act
      final result = await repository.getExchangeRates();
      // assert
      verify(mockRemoteDataSource.getExchangeRatesData());
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  });
}
