import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lufick_test/features/exchange_rates/presentation/bloc/converted_rates_bloc.dart';
import 'package:lufick_test/features/exchange_rates/presentation/bloc/exchange_bloc_bloc.dart';
import 'package:lufick_test/features/exchange_rates/presentation/bloc/exchange_rates_bloc.dart';
import 'package:lufick_test/features/exchange_rates/presentation/widgets/bottom_half.dart';
import 'package:lufick_test/features/exchange_rates/presentation/widgets/top_half.dart';

class ExchangeRatePage extends StatelessWidget {
  final BuildContext context1;

  const ExchangeRatePage({Key key, this.context1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExchangeBlocBloc>(context).add(GetDataForExchangeRates());
    return Scaffold(
      body: BlocBuilder<ExchangeBlocBloc, ExchangeBlocState>(
          builder: (context, state) {
        if (state is EmptyExchange) {
          return EmptyAndErrorWidget(
            message: 'Fetching Data...',
            context: context,
          );
        } else if (state is LoadingExchange) {
          return LoadingWidget();
        } else if (state is LoadedExchangeRates) {
          BlocProvider.of<ConvertedRatesBloc>(context)
              .add(GetDataForConvertedExchangeRates("0"));
          BlocProvider.of<ExchangeRatesBloc>(context).add(GetRefreshDate());
          return AfterLoaded();
        } else if (state is ErrorExchange) {
          return EmptyAndErrorWidget(
            message: state.message,
          );
        }
      }),
    );
  }
}

class AfterLoaded extends StatelessWidget {
  const AfterLoaded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: 20.0),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'EURO',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ])),
          ),
          RefreshDateWidget(buildContext: context)
        ]),
        actions: [RefreshButton(context: context)],
      ),
      body: BuildBody(
        context: context,
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  final BuildContext context;
  const RefreshButton({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        BlocProvider.of<ExchangeBlocBloc>(context)
            .add(GetDataForExchangeRates());
        BlocProvider.of<ExchangeRatesBloc>(context).add(GetRefreshDate());
        BlocProvider.of<ConvertedRatesBloc>(context)
            .add(GetDataForConvertedExchangeRates("0"));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Text("Refresh"),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}

class RefreshDateWidget extends StatelessWidget {
  final BuildContext buildContext;
  const RefreshDateWidget({Key key, this.buildContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
    return Align(
      alignment: Alignment.topLeft,
      child: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
        builder: (context, state) {
          if (state is EmptyRefresh) {
            return EmptyAndErrorWidget(
              message: 'Fetching Data...',
              context: context,
            );
          } else if (state is LoadingRefreshDate) {
            return Container(
              width: 20.0,
              height: 20.0,
              color: Colors.lightGreen,
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedRefreshDate) {
            return RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: 10.0),
                    children: <TextSpan>[
                  TextSpan(
                      text: state.date ?? formattedDate,
                      style: TextStyle(color: Colors.white)),
                ]));
          } else if (state is Error) {
            return EmptyAndErrorWidget(
              message: state.message,
            );
          }
        },
      ),
    );
  }
}

class BuildBody extends StatelessWidget {
  final BuildContext context;
  const BuildBody({Key key, @required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            // Top half
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: TopHalf(),
            ),
            //Bottom half
            Expanded(
              child: BottomHalf(context: context),
            ),
          ],
        ),
      ),
    );
  }
}
