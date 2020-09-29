part of 'converted_rates_bloc.dart';

abstract class ConvertedRatesState extends Equatable {
  final List props1;
  const ConvertedRatesState({this.props1 = const <dynamic>[]});

  @override
  List<Object> get props => [props1];
}

class ConvertedEmpty extends ConvertedRatesState {}

class LoadingConvertedRates extends ConvertedRatesState {}

class LoadedConvertedRates extends ConvertedRatesState {
  final Exchange convertedRates;

  LoadedConvertedRates({@required this.convertedRates})
      : super(props1: [convertedRates]);
}

class ErrorConverted extends ConvertedRatesState {
  final String message;

  ErrorConverted({@required this.message}) : super(props1: [message]);
}
