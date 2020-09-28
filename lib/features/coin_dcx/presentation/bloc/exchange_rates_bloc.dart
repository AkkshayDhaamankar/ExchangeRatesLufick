import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lufick_test/core/error/failures.dart';
import 'package:lufick_test/core/usecases/usecase.dart';
import 'package:lufick_test/features/coin_dcx/domain/usecases/get_refresh_date.dart';

part 'exchange_rates_event.dart';
part 'exchange_rates_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class ExchangeRatesBloc extends Bloc<ExchangeRatesEvent, ExchangeRatesState> {
  final GetRefreshDateUseCase getRefreshDate;

  ExchangeRatesBloc({@required this.getRefreshDate}) : super(EmptyRefresh());

  @override
  Stream<ExchangeRatesState> mapEventToState(
    ExchangeRatesEvent event,
  ) async* {
    if (event is GetRefreshDate) {
      yield LoadingRefreshDate();
      final failureOrRefreshDate = await getRefreshDate.call(NoParams());
      yield failureOrRefreshDate.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (refreshDate) => LoadedRefreshDate(date: refreshDate));
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
