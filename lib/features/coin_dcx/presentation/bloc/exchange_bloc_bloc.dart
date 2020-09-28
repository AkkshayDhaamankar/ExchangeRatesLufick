import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/core/usecases/usecase.dart';
import 'package:lufick_test/features/coin_dcx/domain/entities/exchange.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_exchange_rates.dart';

import 'exchange_rates_bloc.dart';

part 'exchange_bloc_event.dart';
part 'exchange_bloc_state.dart';

class ExchangeBlocBloc extends Bloc<ExchangeBlocEvent, ExchangeBlocState> {
  final GetExchangeRates getExchangeRates;

  ExchangeBlocBloc({@required this.getExchangeRates}) : super(EmptyExchange());

  @override
  Stream<ExchangeBlocState> mapEventToState(
    ExchangeBlocEvent event,
  ) async* {
    if (event is GetDataForExchangeRates) {
      yield LoadingExchange();
      final failureOrExchangeRates = await getExchangeRates.call(NoParams());
      yield failureOrExchangeRates.fold(
          (failure) => ErrorExchange(message: _mapFailureToMessage(failure)),
          (exchangeRatesDataList) =>
              LoadedExchangeRates(exchange: exchangeRatesDataList));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
