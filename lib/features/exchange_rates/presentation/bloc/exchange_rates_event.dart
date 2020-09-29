part of 'exchange_rates_bloc.dart';

abstract class ExchangeRatesEvent extends Equatable {
  final List props1;
  const ExchangeRatesEvent({this.props1 = const <dynamic>[]});

  @override
  List<Object> get props => props1;
}

// class GetDataForExchangeRates extends ExchangeBlocEvent {
//   GetDataForExchangeRates();
// }

// class GetDataForConvertedExchangeRates extends ExchangeRatesEvent {
//   final String numberString;
//   GetDataForConvertedExchangeRates(this.numberString)
//       : super(props1: [numberString]);
// }

class GetRefreshDate extends ExchangeRatesEvent {
  GetRefreshDate();
}
