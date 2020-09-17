import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:cakeboss/backend/data_bloc/data_state.dart';
import 'package:cakeboss/frontend/src/charts/bar.dart';
import 'package:cakeboss/frontend/src/charts/time.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesPage extends StatelessWidget {
  final SalesView state;
  final Login login;
  final mainColor;
  final secondaryColor;
  const SalesPage(
      {Key key, this.state, this.login, this.mainColor, this.secondaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    state.dataTicket2 = state.beginDate == null || state.endDate == null
        ? state.sales.ticketDay.where((i) => i.day.day < 13).toList()
        : state.sales.ticketDay
            .where((i) =>
                i.day.isAfter(state.beginDate.add(Duration(days: -1))) &&
                i.day.isBefore(state.endDate.add(Duration(days: 1))))
            .toList();
    state.data = state.beginDate == null || state.endDate == null
        ? state.sales.dayOrders.where((i) => i.day.day < 13).toList()
        : state.sales.dayOrders
            .where((i) =>
                i.day.isAfter(state.beginDate.add(Duration(days: -1))) &&
                i.day.isBefore(state.endDate.add(Duration(days: 1))))
            .toList();
    return SafeArea(
      bottom: true,
      top: false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: login.establishment.colors.primary.toColor(),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text("Cantidad"),
                ),
                Tab(
                  child: Text("Valor"),
                ),
              ],
            ),
            title: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://chefmenu.co/restaurantes/bogota/tiendas-d1/tiendas-d1-logo.jpg'),
                        ),
                      ),
                      height: 24,
                      width: 24,
                    ),
                    Text('   Ventas')
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ButtonTheme(
                          minWidth: size.width / 3,
                          child: RaisedButton(
                              color: mainColor,
                              textColor: secondaryColor,
                              child: Text(state.beginDate != null
                                  ? "${state.beginDate.day}/${state.beginDate.month}/${state.beginDate.year}"
                                  : 'Fecha inicial'),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: state.beginDate != null
                                      ? state.beginDate
                                      : DateTime.now(),
                                  firstDate: state.sales.dayOrders.first.day,
                                  lastDate: DateTime.now(),
                                ).then((v) {
                                  state.beginDate = v;
                                  state.endDate = v.add(Duration(days: 10));
                                });
                              }),
                        ),
                        ButtonTheme(
                          minWidth: size.width / 3,
                          child: RaisedButton(
                              elevation: 0,
                              color: mainColor,
                              textColor: secondaryColor,
                              child: Text(state.endDate != null
                                  ? "${state.endDate.day}/${state.endDate.month}/${state.endDate.year}"
                                  : 'Fecha final'),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: state.endDate != null
                                      ? state.endDate
                                      : state.beginDate != null
                                          ? state.beginDate
                                              .add(Duration(days: 10))
                                          : DateTime.now(),
                                  firstDate: state.beginDate,
                                  lastDate:
                                      (state.beginDate.add(Duration(days: 10))),
                                ).then((v) {
                                  state.endDate = v;
                                });
                              }),
                        )
                      ]),
                ]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  child: Column(
                    children: <Widget>[
                      BarChart(
                        button: false,
                        height: size.height * (state.data.length / 20),
                        seriesList: state.dataPedidosDiaCant(),
                        title: 'Cantidad de pedidos',
                      ),
                      TimeChart(
                        seriesList: state.dataPedidosDiaCantTime(),
                        height: size.height * 0.3,
                        title: 'Cantidad de pedidos',
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Cantidad de pedidos por tienda',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return _MyDialog(
                                              shatblisments:
                                                  state.sales.storeOrders,
                                              selectedStablishments: state
                                                  .dataPedidosTiendaSelected,
                                              onSelectedStablishmentsListChanged:
                                                  (cities) {
                                                state.dataPedidosTiendaSelected =
                                                    cities;
                                              });
                                        });
                                  },
                                  child: Text('Elegir establecimientos')),
                              Container(
                                width: size.width,
                                height: size.height *
                                    (state.dataPedidosTiendaSelected.length /
                                        30),
                                child: state.dataPedidosTiendaSelected.length >
                                        0
                                    ? charts.BarChart(
                                        state.dataPedidosTiendaCant(),
                                        vertical: false,
                                        animate: true,
                                        barRendererDecorator:
                                            charts.BarLabelDecorator<String>(),
                                        domainAxis: charts.OrdinalAxisSpec(
                                            renderSpec:
                                                charts.NoneRenderSpec()),
                                      )
                                    : Text('Seleccione algun establecimiento'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Cantidad de pedidos',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: size.width,
                                height: size.height * 0.3,
                                child: charts.PieChart(state.dataFranjasCant(),
                                    animate: true,
                                    defaultRenderer: charts.ArcRendererConfig(
                                        arcWidth: 30,
                                        arcRendererDecorators: [
                                          charts.ArcLabelDecorator()
                                        ])),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Cantidad por productos',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return _MyDialogProducts(
                                              products: state.sales.products,
                                              selectedProducts:
                                                  state.dataProducts2,
                                              onSelectedProductsListChanged:
                                                  (cities) {
                                                state.dataProducts2 = cities;
                                              });
                                        });
                                  },
                                  child: Text('Elegir Productos')),
                              Container(
                                width: size.width,
                                height: size.height *
                                    (state.dataProducts2.length / 30),
                                child: state.dataProducts2.length > 0
                                    ? charts.BarChart(
                                        state.dataProductsCant(),
                                        vertical: false,
                                        animate: true,
                                        barRendererDecorator:
                                            charts.BarLabelDecorator<String>(),
                                        domainAxis: charts.OrdinalAxisSpec(
                                            renderSpec:
                                                charts.NoneRenderSpec()),
                                      )
                                    : Text('Seleccione algun producto'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TimeChart(
                        seriesList: state.dataDeliveriesAfterHours(),
                        height: size.height * 0.3,
                        title: 'Pedidos fuera del horario',
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      BarChart(
                        seriesList: state.dataPedidosDiaVal(),
                        height: size.height * (state.data.length / 20),
                        title: 'Valor de pedidos por dia',
                        button: false,
                      ),
                      TimeChart(
                        seriesList: state.dataPedidosDiaValTime(),
                        height: size.height * 0.3,
                        title: 'Cantidad de pedidos',
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Valor de pedidos por tienda',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return _MyDialog(
                                              shatblisments:
                                                  state.sales.storeOrders,
                                              selectedStablishments: state
                                                  .dataPedidosTiendaSelected,
                                              onSelectedStablishmentsListChanged:
                                                  (cities) {
                                                state.dataPedidosTiendaSelected =
                                                    cities;
                                              });
                                        });
                                  },
                                  child: Text('Elegir establecimientos')),
                              Container(
                                width: size.width,
                                height: size.height *
                                    (state.dataPedidosTiendaSelected.length /
                                        30),
                                child: state.dataPedidosTiendaSelected.length >
                                        0
                                    ? charts.BarChart(
                                        state.dataPedidosTiendaVal(),
                                        vertical: false,
                                        animate: true,
                                        barRendererDecorator:
                                            charts.BarLabelDecorator<String>(),
                                        domainAxis: charts.OrdinalAxisSpec(
                                            renderSpec:
                                                charts.NoneRenderSpec()),
                                      )
                                    : Text('Seleccione algun establecimiento'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Cantidad de pedidos',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: size.width,
                                height: size.height * 0.3,
                                child: charts.PieChart(state.dataFranjasVal(),
                                    animate: true,
                                    defaultRenderer: charts.ArcRendererConfig(
                                        arcWidth: 30,
                                        arcRendererDecorators: [
                                          charts.ArcLabelDecorator()
                                        ])),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Valor por productos',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return _MyDialogProducts(
                                              products: state.sales.products,
                                              selectedProducts:
                                                  state.dataProducts2,
                                              onSelectedProductsListChanged:
                                                  (cities) {
                                                state.dataProducts2 = cities;
                                              });
                                        });
                                  },
                                  child: Text('Elegir Productos')),
                              Container(
                                width: size.width,
                                height: size.height *
                                    (state.dataProducts2.length / 30),
                                child: state.dataProducts2.length > 0
                                    ? charts.BarChart(
                                        state.dataProductsVal(),
                                        vertical: false,
                                        animate: true,
                                        barRendererDecorator:
                                            charts.BarLabelDecorator<String>(),
                                        domainAxis: charts.OrdinalAxisSpec(
                                            renderSpec:
                                                charts.NoneRenderSpec()),
                                      )
                                    : Text('Seleccione algun producto'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyDialog extends StatefulWidget {
  _MyDialog({
    this.shatblisments,
    this.selectedStablishments,
    this.onSelectedStablishmentsListChanged,
  });

  final List<StoreOrders> shatblisments;
  final List<StoreOrders> selectedStablishments;
  final ValueChanged<List<StoreOrders>> onSelectedStablishmentsListChanged;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<StoreOrders> _tempSelectedStablishments = [];

  @override
  void initState() {
    _tempSelectedStablishments = widget.selectedStablishments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Text(
            'Tiendas',
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.shatblisments.length,
                itemBuilder: (BuildContext context, int index) {
                  final stablishmentName = widget.shatblisments[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(stablishmentName.store),
                        value: _tempSelectedStablishments
                            .contains(stablishmentName),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedStablishments
                                .contains(stablishmentName)) {
                              setState(() {
                                _tempSelectedStablishments
                                    .add(stablishmentName);
                              });
                            }
                          } else {
                            if (_tempSelectedStablishments
                                .contains(stablishmentName)) {
                              setState(() {
                                _tempSelectedStablishments.removeWhere(
                                    (StoreOrders stablishment) =>
                                        stablishment == stablishmentName);
                              });
                            }
                          }
                          widget.onSelectedStablishmentsListChanged(
                              _tempSelectedStablishments);
                        }),
                  );
                }),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.red,
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyDialogProducts extends StatefulWidget {
  _MyDialogProducts({
    this.products,
    this.selectedProducts,
    this.onSelectedProductsListChanged,
  });

  final List<Products> products;
  final List<Products> selectedProducts;
  final ValueChanged<List<Products>> onSelectedProductsListChanged;

  @override
  _MyDialogProductsState createState() => _MyDialogProductsState();
}

class _MyDialogProductsState extends State<_MyDialogProducts> {
  List<Products> _tempSelectedProducts = [];

  @override
  void initState() {
    _tempSelectedProducts = widget.selectedProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Text(
            'Tiendas',
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final stablishmentName = widget.products[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(stablishmentName.product),
                        value: _tempSelectedProducts.contains(stablishmentName),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedProducts
                                .contains(stablishmentName)) {
                              setState(() {
                                _tempSelectedProducts.add(stablishmentName);
                              });
                            }
                          } else {
                            if (_tempSelectedProducts
                                .contains(stablishmentName)) {
                              setState(() {
                                _tempSelectedProducts.removeWhere(
                                    (Products stablishment) =>
                                        stablishment == stablishmentName);
                              });
                            }
                          }
                          widget.onSelectedProductsListChanged(
                              _tempSelectedProducts);
                        }),
                  );
                }),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.red,
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
