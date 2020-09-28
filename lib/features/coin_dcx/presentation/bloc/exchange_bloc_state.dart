part of 'exchange_bloc_bloc.dart';

abstract class ExchangeBlocState extends Equatable {
  final List props1;
  const ExchangeBlocState({this.props1 = const <dynamic>[]});

  @override
  List<Object> get props => [props1];
}

class EmptyExchange extends ExchangeBlocState {}

class LoadingExchange extends ExchangeBlocState {}

class LoadedExchangeRates extends ExchangeBlocState {
  final Exchange exchange;

  LoadedExchangeRates({@required this.exchange}) : super(props1: [exchange]);
}

class ErrorExchange extends ExchangeBlocState {
  final String message;

  ErrorExchange({@required this.message}) : super(props1: [message]);
}
