import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lufick_test/core/error/exceptions.dart';
import 'package:lufick_test/features/exchange_rates/data/models/exhange_model.dart';

abstract class ExchangeRatesRemoteDataSource {
  Future<ExchangeModel> getExchangeRatesData();
}

class ExchangeRatesRemoteDataSourceImpl
    implements ExchangeRatesRemoteDataSource {
  final http.Client client;
  ExchangeRatesRemoteDataSourceImpl({@required this.client});
  ExchangeModel exchangeModel;

  @override
  Future<ExchangeModel> getExchangeRatesData() async {
    final responseExchangeIcon = await client.get(
        'https://api.exchangeratesapi.io/latest',
        headers: {'Accept': 'application/json'});
    if (responseExchangeIcon.statusCode == 200) {
      return ExchangeModel.fromJson(json.decode(responseExchangeIcon.body));
    } else {
      throw ServerException();
    }
  }
}
