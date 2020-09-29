import 'package:flutter/material.dart';
import 'package:lufick_test/features/exchange_rates/domain/entities/exchange.dart';

class ExchangeModel extends Exchange {
  ExchangeModel(
      {@required List<RatesModel> rates,
      @required String base,
      @required String date})
      : super(rates: rates, base: base, date: date);

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> ratesObjsJson = json['rates'];
    var ratesKeys = ratesObjsJson.keys.toList();

    List<RatesModel> _rates = ratesKeys
        .map((rateJson) => RatesModel.fromJson(json, rateJson))
        .toList();

    return ExchangeModel(
        rates: _rates,
        base: json["base"] as String,
        date: json["date"] as String);
  }

  Map<String, dynamic> toJson() {
    return {"rates": rates.join(","), "base": base, "date": date};
  }
}

class RatesModel extends Rates {
  RatesModel({@required String currency, @required double value})
      : super(currency: currency, value: value);

  factory RatesModel.fromJson(Map<String, dynamic> json, String key) {
    return RatesModel(currency: key, value: json['rates'][key]);
  }

  Map<String, dynamic> toJson(RatesModel ratesModel) {
    return {ratesModel.currency: ratesModel.value};
  }
}
