import 'package:lufick_test/core/error/exceptions.dart';
import 'package:lufick_test/features/exchange_rates/data/models/exhange_model.dart';
import 'package:lufick_test/features/exchange_rates/data/models/moor_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class ConvertedExchangeRatesLocalDataSource {
  Future<ExchangeModel> getConvertedExchangeRatesData(int number);
  Future<void> cacheRefreshDate(String date);
  Future<void> cacheExchangeRates(ExchangeModel exchangeModel);
  Future<String> getRefreshDate();
}

const CACHED_REFRESH_DATE = 'REFRESH_DATE';

class ConvertedExchangeRatesLocalDataSourceImpl
    extends ConvertedExchangeRatesLocalDataSource {
  final SharedPreferences sharedPreferences;
  final database = AppDatabase();
  ConvertedExchangeRatesLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<ExchangeModel> getConvertedExchangeRatesData(int number) async {
    List<CVRate> list = await database.getAllTasks();
    List<RatesModel> listModels = List();
    for (int i = 0; i < list.length; i++) {
      CVRate cvRate = list.elementAt(i);
      listModels.add(RatesModel(
          currency: cvRate.currency,
          value: number != 0 ? cvRate.value * number : cvRate.value));
    }
    return ExchangeModel(base: "EURO", date: "", rates: listModels);
  }

  @override
  Future<void> cacheRefreshDate(String date) {
    sharedPreferences.setBool('first', false);
    return sharedPreferences.setString(CACHED_REFRESH_DATE, date);
  }

  @override
  Future<void> cacheExchangeRates(ExchangeModel exchangeModel) {
    database.resetDb();
    List<RatesModel> list = exchangeModel.rates;
    for (int i = 0; i < list.length; i++) {
      RatesModel ratesModel = list.elementAt(i);
      database.insertTask(
          CVRate(currency: ratesModel.currency, value: ratesModel.value));
    }
  }

  @override
  Future<String> getRefreshDate() {
    final refreshDate = sharedPreferences.getString(CACHED_REFRESH_DATE);
    if (refreshDate != null) {
      return Future.value(refreshDate);
    } else {
      throw CacheException();
    }
  }
}
