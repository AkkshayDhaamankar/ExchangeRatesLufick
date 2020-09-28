import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lufick_test/core/error/exceptions.dart';
import 'package:lufick_test/features/coin_dcx/data/models/exhange_model.dart';

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

/**
 * 
 *  @override
  Future<ExchangeModel> ge() async {
    final uri = Uri.https('rest.coinapi.io', '/v1/assets', queryParamters);
    final responseAssetIcon = await client.get(
        'https://rest.coinapi.io/v1/assets/icons/128',
        headers: {'Accept': 'application/json', 'X-CoinAPI-Key': 'API_KEY'});
    final responseAssetData = await client.get(
      uri,
      headers: {'Accept': 'application/json', 'X-CoinAPI-Key': 'API_KEY'},
    );
    if (responseAssetIcon.statusCode == 200 &&
        responseAssetData.statusCode == 200) {
      var jsonArrayOfAssetIcons = jsonDecode(responseAssetIcon.body) as List;

      var jsonArrayOfAssetData = jsonDecode(responseAssetData.body) as List;
      for (int i = 0; i < jsonArrayOfAssetIcons.length; i++) {
        listCoinAssetIcons.add(
            CoinAssetIconModel.fromJson(jsonArrayOfAssetIcons.elementAt(i)));
      }
      for (int i = 0; i < jsonArrayOfAssetData.length; i++) {
        CoinAssetIconModel coinAssetIconModel = listCoinAssetIcons.firstWhere(
            (element) =>
                element.assetId == jsonArrayOfAssetData[i]['asset_id']);

        listCoinAssets.add(CoinAssetsModel.fromJson(
            jsonArrayOfAssetData.elementAt(i), coinAssetIconModel.assetIcon));
      }

      return listCoinAssets;
    } else {
      throw ServerException();
    }
  }

 */
