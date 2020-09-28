import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:lufick_test/features/coin_dcx/data/datasources/converted_exchange_rates_local_data_source.dart';
import 'package:lufick_test/features/coin_dcx/data/datasources/exchange_rates_remote_data_source.dart';
import 'package:lufick_test/features/coin_dcx/data/repositories/exchange_rates_repository_impl.dart';
import 'package:lufick_test/features/coin_dcx/domain/repositories/exchange_rate_repository.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_converted_rates.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_exchange_rates.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_refresh_date.dart';
import 'package:lufick_test/features/coin_dcx/presentation/bloc/converted_rates_bloc.dart';
import 'package:lufick_test/features/coin_dcx/presentation/bloc/exchange_bloc_bloc.dart';
import 'package:lufick_test/features/coin_dcx/presentation/bloc/exchange_rates_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Exchange Rates (Repositories, use cases, data sources)

  /*
    * * RegisterFactory Method always creates new instance whenever its called.
    * * Here Bloc which is presentation logic component must be registered as 
    * * Factory because if we navigate to some other screen then we need to 
    * * dispose the observers, or clean memory to prevent strong reference to 
    * * the instances. 
   */
  //? Bloc
  serviceLocator.registerFactory(() => ExchangeRatesBloc(
        getRefreshDate: serviceLocator(),
      ));

  serviceLocator.registerFactory(
      () => ExchangeBlocBloc(getExchangeRates: serviceLocator()));

  serviceLocator.registerFactory(() => ConvertedRatesBloc(
        getConvertedRates: serviceLocator(),
      ));
  /**
   * * SingleTon or LazySingleTon will provide the same instance for the 
   * * subsequent calls
   */
  //? Use cases
  //? Use cases does not hold any state i.e. changing information
  //? So only a single instance is enough. LazySingleTon is registered when
  //? its required and Only Singleton is registered when the app is started.
  serviceLocator
      .registerLazySingleton(() => GetExchangeRates(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetRefreshDateUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetConvertedRates(serviceLocator()));

  //? Repository
  serviceLocator.registerLazySingleton<ExchangeRateRepository>(() =>
      ExchangeRateRepositoryImpl(
          exchangeRatesRemoteDataSource: serviceLocator(),
          networkInfo: serviceLocator(),
          convertedExchangeRatesLocalDataSource: serviceLocator()));

  //? Data Sources
  serviceLocator.registerLazySingleton<ExchangeRatesRemoteDataSource>(
      () => ExchangeRatesRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerLazySingleton<ConvertedExchangeRatesLocalDataSource>(
      () => ConvertedExchangeRatesLocalDataSourceImpl(
          sharedPreferences: serviceLocator()));

  //! Core - network info etc
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));

  //! External -  HTTP, DataConnection Checker, etc
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
