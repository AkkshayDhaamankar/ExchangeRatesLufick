import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lufick_test/features/exchange_rates/domain/entities/exchange.dart';
import 'package:lufick_test/features/exchange_rates/presentation/bloc/converted_rates_bloc.dart';

class BottomHalf extends StatelessWidget {
  final BuildContext context;
  BottomHalf({@required this.context});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConvertedRatesBloc, ConvertedRatesState>(
      builder: (context, state) {
        if (state is ConvertedEmpty) {
          return EmptyAndErrorWidget(
            message: 'Fetching Data...',
            context: context,
          );
        } else if (state is LoadingConvertedRates) {
          return LoadingWidget();
        } else if (state is LoadedConvertedRates) {
          return RatesDataDisplay(
            exchange: state.convertedRates,
          );
        } else if (state is ErrorConverted) {
          return EmptyAndErrorWidget(
            message: state.message,
          );
        }
      },
    );
  }
}

class EmptyAndErrorWidget extends StatelessWidget {
  final String message;
  final BuildContext context;
  const EmptyAndErrorWidget({Key key, this.message, this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(message),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

class RatesDataDisplay extends StatelessWidget {
  final Exchange exchange;
  const RatesDataDisplay({Key key, this.exchange})
      : assert(exchange != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: exchange.rates.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return ListTile(
                title: Text(exchange.rates.elementAt(index).currency +
                    " : " +
                    exchange.rates.elementAt(index).value.toStringAsFixed(4)),
              );
            }),
      ),
    );
  }
}
