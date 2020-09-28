import 'package:flutter/material.dart';
import 'package:lufick_test/features/coin_dcx/presentation/widgets/rate_controls.dart';

class TopHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RateControls(),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: double.maxFinite,
          height: 30.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), color: Colors.grey[200]),
          child: Text(
            '    View Converted Rates',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 10.0),
          ),
        ),
      ],
    );
  }
}
