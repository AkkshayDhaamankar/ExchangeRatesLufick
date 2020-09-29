import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lufick_test/core/error/exceptions.dart';
import 'package:lufick_test/features/exchange_rates/data/datasources/exchange_rates_remote_data_source.dart';
import 'package:lufick_test/features/exchange_rates/data/models/exhange_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ExchangeRatesRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  void setupMockHttpClientSuccess200() {
    when(mockHttpClient.get('https://api.exchangeratesapi.io/latest',
            headers: anyNamed('headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('exchange_rates.json'), 200));
  }

  void setupMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ExchangeRatesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getExchangeRates', () {
    //var jSON = json.decode(fixture('exchange_rates.json'));
    List<RatesModel> tRatesList = [
      RatesModel(currency: "CAD", value: 1.556),
      RatesModel(currency: "RUB", value: 90.405),
      RatesModel(currency: "MXN", value: 26.0006),
    ];
    final ExchangeModel tExchange =
        ExchangeModel(rates: tRatesList, base: "EUR", date: "2020-09-25");
    test(
      '''should perform a GET request 
    on a url with application/json header''',
      () async {
        //arrange
        setupMockHttpClientSuccess200();
        //act
        await dataSource.getExchangeRatesData();
        //assert
        verify(mockHttpClient.get(
          'https://api.exchangeratesapi.io/latest',
          headers: {'Accept': 'application/json'},
        ));
      },
    );

    test('''should return ExchangeRates when the response code is 200''',
        () async {
      //arrange
      setupMockHttpClientSuccess200();
      //act
      final result = await dataSource.getExchangeRatesData();
      //assert
      expect(result, equals(tExchange));
    });

    test(
        '''should return a ServerException when the response code is 404 or other''',
        () async {
      //arrange
      setupMockHttpClientFailure404();
      //act
      final call = dataSource.getExchangeRatesData;
      //assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
