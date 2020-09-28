part of 'exchange_bloc_bloc.dart';

abstract class ExchangeBlocEvent extends Equatable {
  final List props1;
  const ExchangeBlocEvent({this.props1 = const <dynamic>[]});

  @override
  List<Object> get props => props1;
}

class GetDataForExchangeRates extends ExchangeBlocEvent {
  GetDataForExchangeRates();
}
