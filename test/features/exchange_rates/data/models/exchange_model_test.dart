import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lufick_test/features/exchange_rates/data/models/exhange_model.dart';
import 'package:lufick_test/features/exchange_rates/domain/entities/exchange.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  List<RatesModel> tRatesList = [
    RatesModel(currency: "CAD", value: 1.556),
    RatesModel(currency: "RUB", value: 90.405),
    RatesModel(currency: "MXN", value: 26.0006),
  ];
  final ExchangeModel tExchange =
      ExchangeModel(rates: tRatesList, base: "EUR", date: "2020-09-25");
  test('should be a subclass of Exchange entity', () async {
    //assert
    expect(tExchange, isA<Exchange>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      final dynamic jsonMap = json.decode(fixture('exchange_rates.json'));
      //act
      final result = ExchangeModel.fromJson(jsonMap);
      // assert
      expect(result, tExchange);
    });
  });
}
