import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Exchange extends Equatable {
  final List<Rates> rates;
  final String base;
  final String date;

  Exchange({
    @required this.rates,
    @required this.base,
    @required this.date,
  });

  @override
  List<Object> get props => [rates, base, date];
}

class Rates extends Equatable {
  final String currency;
  final double value;

  Rates({@required this.currency, @required this.value});

  @override
  List<Object> get props => [currency, value];
}
