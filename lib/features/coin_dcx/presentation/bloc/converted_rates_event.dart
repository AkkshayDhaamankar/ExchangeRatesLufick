part of 'converted_rates_bloc.dart';

abstract class ConvertedRatesEvent extends Equatable {
  final List props1;
  const ConvertedRatesEvent({this.props1 = const <dynamic>[]});

  @override
  List<Object> get props => props1;
}

class GetDataForConvertedExchangeRates extends ConvertedRatesEvent {
  final String numberString;
  GetDataForConvertedExchangeRates(this.numberString)
      : super(props1: [numberString]);
}
