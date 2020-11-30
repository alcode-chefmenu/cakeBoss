import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

class Indicators extends StatefulWidget {
  @override
  _IndicatorsState createState() => _IndicatorsState();
}

// List<Widget> _tiles = <Widget>[
//   const _CustomGridCard(
//     title: 'Pedidos Ingresados',
//     color: Colors.lightBlue,
//     valor: 200,
//     meta: 400,
//     subtitle: '1,469',
//   ),
//   _CustomGridCard(
//     title: 'Congelados y Pendientes',
//     color: Colors.green,
//     valor: 10542800,
//     meta: 15542800,
//     subtitle: '0',
//   ),
//   const _CustomGridCard(
//     title: 'Pedidos Entregados',
//     color: Colors.amber,
//     valor: 1020,
//     meta: 2020,
//     subtitle: '234',
//   ),
//   const _CustomGridCard(
//     title: 'Pedidos Entregados',
//     color: Colors.brown,
//     valor: 1020,
//     meta: 1203,
//     subtitle: '% 16',
//   ),
//   const _CustomGridCard(
//     title: 'Pedidos en Proceso',
//     color: Colors.deepOrange,
//     valor: 4,
//     meta: 10,
//     subtitle: '1,156',
//   ),
//   const _CustomGridCard(
//     title: 'Pedidos en Proceso',
//     color: Colors.indigo,
//     valor: 1,
//     meta: 3,
//     subtitle: '% 79',
//   ),
//   const _CustomGridCard(
//     title: 'Pedidos Cancelados',
//     color: Colors.indigo,
//     valor: 1,
//     meta: 3,
//     subtitle: '79',
//   ),
//   const _CustomGridCard(
//     title: 'Pedidos Cancelados',
//     color: Colors.indigo,
//     valor: 1,
//     meta: 3,
//     subtitle: '% 5',
//   ),
// ];

// List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(2, 1),
// ];

class _IndicatorsState extends State<Indicators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NACIONAL HISTÓRICO"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 12.0),
              //   child: Container(
              //     height: 300,
              //     child: StaggeredGridView.count(
              //       crossAxisCount: 4,
              //       staggeredTiles: _staggeredTiles,
              //       children: _tiles,
              //       mainAxisSpacing: 4.0,
              //       crossAxisSpacing: 4.0,
              //       padding: const EdgeInsets.all(4.0),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // Center(
              //   child: Text(
              //     "HISTORICO DIARIO",
              //   ),
              // ),
              // SizedBox(height: 20),
              // Text(
              //   "HISTÓRICO DIARIO MES ACTUAL",
              // ),
              // Container(
              //   padding: EdgeInsets.all(8),
              //   height: 200,
              //   child: charts.BarChart(
              //     dataPedidosDiaCant(),
              //   ),
              // ),
              // SizedBox(height: 20),
              // Text(
              //   "PEDIDOS POR ESTATUS - ATRASADOS -CANCELADOS",
              // ),
              // Container(
              //   padding: EdgeInsets.only(left: 30, top: 20),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Container(
              //             color: Colors.blue,
              //             height: 10,
              //             width: 10,
              //           ),
              //           SizedBox(width: 10),
              //           Text("Entregados"),
              //           SizedBox(width: 10),
              //           Container(
              //             color: Colors.red,
              //             height: 10,
              //             width: 10,
              //           ),
              //           SizedBox(width: 10),
              //           Text("Congelados"),
              //         ],
              //       ),
              //       SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Container(
              //             color: Colors.orange,
              //             height: 10,
              //             width: 10,
              //           ),
              //           SizedBox(width: 10),
              //           Text("Canelados"),
              //           SizedBox(width: 10),
              //           Container(
              //             color: Colors.green,
              //             height: 10,
              //             width: 10,
              //           ),
              //           SizedBox(width: 10),
              //           Text("En Proceso"),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.all(8),
              //   height: 200,
              //   child: charts.BarChart(
              //     createSampleData(),
              //     barGroupingType: charts.BarGroupingType.stacked,
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(8),
                height: 200,
                child: charts.TimeSeriesChart(
                  _createSampleDatas(),
                  animate: true,
                  defaultRenderer:
                      new charts.LineRendererConfig(includePoints: true),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: 200,
                child: charts.OrdinalComboChart(
                  _createSampleData(),
                  customSeriesRenderers: [
                    new charts.LineRendererConfig(
                        // ID used to link series to this renderer.
                        customRendererId: 'customLine')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 100),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 200),
      new OrdinalSales('2017', 150),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green[600]),
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Mobile ',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Colors.yellow[700]),
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }

  static List<charts.Series<LinearSales, DateTime>> _createSampleDatas() {
    final data = [
      new LinearSales(DateTime(2020, 09, 20), 80),
      new LinearSales(DateTime(2020, 09, 21), 25),
      new LinearSales(DateTime(2020, 09, 22), 100),
      new LinearSales(DateTime(2020, 09, 23), 10),
      new LinearSales(DateTime(2020, 09, 24), 90),
    ];

    return [
      new charts.Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.day,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

//   static List<charts.Series<EstatusPedidos, String>> createSampleData() {
//     final desktopSalesDataA = [
//       new EstatusPedidos('Bogotá', 'Entregados', 200, Colors.blue),
//       new EstatusPedidos('Costa', 'Entregados', 325, Colors.blue),
//       new EstatusPedidos('Pacífico', 'Entregados', 100, Colors.blue),
//       new EstatusPedidos('Antioquia', 'Entregados', 250, Colors.blue),
//     ];

//     final tableSalesDataA = [
//       new EstatusPedidos('Bogotá', 'Congelados', 25, Colors.red),
//       new EstatusPedidos('Costa', 'Congelados', 50, Colors.red),
//       new EstatusPedidos('Pacífico', 'Congelados', 50, Colors.red),
//       new EstatusPedidos('Antioquia', 'Congelados', 20, Colors.red),
//     ];

//     final mobileSalesDataA = [
//       new EstatusPedidos('Bogotá', 'Cancelados', 90, Colors.orange),
//       new EstatusPedidos('Costa', 'Cancelados', 55, Colors.orange),
//       new EstatusPedidos('Pacífico', 'Cancelados', 50, Colors.orange),
//       new EstatusPedidos('Antioquia', 'Cancelados', 45, Colors.orange),
//     ];

//     final desktopSalesDataB = [
//       new EstatusPedidos('Bogotá', 'En Proceso', 75, Colors.green),
//       new EstatusPedidos('Costa', 'En Proceso', 25, Colors.green),
//       new EstatusPedidos('Pacífico', 'En Proceso', 100, Colors.green),
//       new EstatusPedidos('Antioquia', 'En Proceso', 75, Colors.green),
//     ];

//     return [
//       new charts.Series<EstatusPedidos, String>(
//         id: 'Desktop A',
//         domainFn: (EstatusPedidos sales, _) => sales.city,
//         measureFn: (EstatusPedidos sales, _) => sales.sales,
//         data: desktopSalesDataA,
//         colorFn: (EstatusPedidos i, __) =>
//             charts.ColorUtil.fromDartColor(i.color),
//       ),
//       new charts.Series<EstatusPedidos, String>(
//         id: 'Tablet A',
//         domainFn: (EstatusPedidos sales, _) => sales.city,
//         measureFn: (EstatusPedidos sales, _) => sales.sales,
//         data: tableSalesDataA,
//         colorFn: (EstatusPedidos i, __) =>
//             charts.ColorUtil.fromDartColor(i.color),
//       ),
//       new charts.Series<EstatusPedidos, String>(
//         id: 'Mobile A',
//         domainFn: (EstatusPedidos sales, _) => sales.city,
//         measureFn: (EstatusPedidos sales, _) => sales.sales,
//         domainLowerBoundFn: (EstatusPedidos sales, _) => sales.status,
//         data: mobileSalesDataA,
//         colorFn: (EstatusPedidos i, __) =>
//             charts.ColorUtil.fromDartColor(i.color),
//       ),
//       new charts.Series<EstatusPedidos, String>(
//         id: 'Desktop B',
//         domainFn: (EstatusPedidos sales, _) => sales.city,
//         measureFn: (EstatusPedidos sales, _) => sales.sales,
//         data: desktopSalesDataB,
//         colorFn: (EstatusPedidos i, __) =>
//             charts.ColorUtil.fromDartColor(i.color),
//       ),
//     ];
  //  }

//   final data = [
//     new OrdinalSales('Sep/ 18 / 2020', 1063, Colors.red),
//     new OrdinalSales('Sep/ 19 / 2020', 1002, Colors.red),
//     new OrdinalSales('Sep/ 20 / 2020', 995, Colors.red),
//     new OrdinalSales('Sep/ 21 / 2020', 1385, Colors.red),
//   ];

//   List<charts.Series<OrdinalSales, String>> dataPedidosDiaCant() {
//     return [
//       charts.Series<OrdinalSales, String>(
//           id: 'Pedidos dia',
//           data: data,
//           domainFn: (OrdinalSales time, __) => "${time.day} ",
//           measureFn: (OrdinalSales time, __) => time.amount,
//           colorFn: (OrdinalSales i, __) =>
//               charts.ColorUtil.fromDartColor(i.color),
//           labelAccessorFn: (OrdinalSales time, _) => '${time.day}')
//     ];
//   }
}

// class OrdinalSales {
//   final String day;
//   final int amount;
//   final Color color;

//   OrdinalSales(this.day, this.amount, this.color);
// }

// class EstatusPedidos {
//   final String status;
//   final String city;
//   final int sales;
//   final Color color;

//   EstatusPedidos(this.city, this.status, this.sales, this.color);
// }

// class _CustomGridCard extends StatelessWidget {
//   const _CustomGridCard({
//     this.title,
//     this.color,
//     this.destino,
//     this.valor,
//     this.meta,
//     this.subtitle,
//   });
//   final String title;
//   final Color color;
//   final Widget destino;
//   final double valor;
//   final double meta;
//   final String subtitle;
//   @override
//   Widget build(BuildContext context) {
//     final colorFondo = Colors.white;
//     var colorContenido = color /*Color.fromRGBO(219, 202, 72, 1)*/;
//     return Card(
//       borderOnForeground: true,
//       elevation: 8,
//       shape: RoundedRectangleBorder(
//           side: BorderSide(
//             color: colorContenido,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(8)),
//       color: colorFondo,
//       child: InkWell(
//         onTap: () {},
//         child: Center(
//           child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text(
//                     '$title',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: colorContenido,
//                       fontSize: 20,
//                     ),
//                   ),
//                   //SizedBox(height: 8),
//                   Text(
//                     '$subtitle',
//                     style: TextStyle(
//                         color: colorContenido,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
class LinearSales {
  final DateTime day;
  final int sales;

  LinearSales(this.day, this.sales);
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
