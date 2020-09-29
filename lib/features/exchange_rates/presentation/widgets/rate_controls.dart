import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lufick_test/features/exchange_rates/presentation/bloc/converted_rates_bloc.dart';

class RateControls extends StatefulWidget {
  const RateControls({
    Key key,
  }) : super(key: key);

  @override
  _RateControlsState createState() => _RateControlsState();
}

class _RateControlsState extends State<RateControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Euro\'s To Convert ',
          ),
          onChanged: (value) {
            inputStr = value;
          },
        ),
        SizedBox(height: 10),
        RaisedButton(
          child: Text('Convert'),
          onPressed: dispatchConvertedRates,
        ),
      ],
    );
  }

  void dispatchConvertedRates() {
    controller.clear();
    BlocProvider.of<ConvertedRatesBloc>(context)
        .add(GetDataForConvertedExchangeRates(inputStr));
  }
}
