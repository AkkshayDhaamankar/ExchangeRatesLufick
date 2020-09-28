import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/coin_dcx/presentation/bloc/converted_rates_bloc.dart';
import 'features/coin_dcx/presentation/bloc/exchange_bloc_bloc.dart';
import 'features/coin_dcx/presentation/bloc/exchange_rates_bloc.dart';
import 'features/coin_dcx/presentation/pages/exchange_rate_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<ExchangeRatesBloc>()),
          BlocProvider(create: (_) => serviceLocator<ExchangeBlocBloc>()),
          BlocProvider(create: (_) => serviceLocator<ConvertedRatesBloc>())
        ],
        child: MaterialApp(
          title: 'ExchangeRates',
          home: ExchangeRatePage(
            context1: context,
          ),
        ));
  }
}
