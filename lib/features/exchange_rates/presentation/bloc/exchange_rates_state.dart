part of 'exchange_rates_bloc.dart';

abstract class ExchangeRatesState extends Equatable {
  final List props1;
  const ExchangeRatesState({this.props1 = const <dynamic>[]});

  @override
  List<Object> get props => [props1];
}

class EmptyRefresh extends ExchangeRatesState {}

class LoadingRefreshDate extends ExchangeRatesState {}

class LoadedRefreshDate extends ExchangeRatesState {
  final String date;

  LoadedRefreshDate({@required this.date}) : super(props1: [date]);
}

class Error extends ExchangeRatesState {
  final String message;

  Error({@required this.message}) : super(props1: [message]);
}
