import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/features/coin_dcx/domain/entities/exchange.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_converted_rates.dart';

import 'exchange_rates_bloc.dart';

part 'converted_rates_event.dart';
part 'converted_rates_state.dart';

class ConvertedRatesBloc
    extends Bloc<ConvertedRatesEvent, ConvertedRatesState> {
  final GetConvertedRates getConvertedRates;
  ConvertedRatesBloc({@required this.getConvertedRates})
      : super(ConvertedEmpty());

  @override
  Stream<ConvertedRatesState> mapEventToState(
    ConvertedRatesEvent event,
  ) async* {
    if (event is GetDataForConvertedExchangeRates) {
      yield LoadingConvertedRates();
      final failureOrConvertedRates = await getConvertedRates
          .call(Params(number: int.parse(event.numberString)));
      yield failureOrConvertedRates.fold(
          (failure) => ErrorConverted(message: _mapFailureToMessage(failure)),
          (convertedRates) =>
              LoadedConvertedRates(convertedRates: convertedRates));
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
