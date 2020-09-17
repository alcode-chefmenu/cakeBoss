import 'package:cakeboss/backend/data_bloc/bloc.dart';
import 'package:cakeboss/frontend/src/charts/bar.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  final SalesView state;
  const TicketPage({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            BarChart(
              seriesList: state.dataTicket(),
              height: size.height * (state.dataTicket2.length / 20),
              title: 'Ticket Promedio por dia',
              button: false,
            ),
            BarChart(
              seriesList: state.dataTicketStore(),
              height: size.height * 0.4,
              title: 'Ticket Promedio por tienda',
              button: false,
            )
          ],
        ),
      ),
    );
  }
}
