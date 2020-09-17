import 'package:cakeboss/backend/authentication_bloc/bloc.dart';
import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:cakeboss/backend/data_bloc/bloc.dart';
import 'package:cakeboss/backend/data_bloc/data_bloc.dart';
import 'package:cakeboss/backend/login_bloc/bloc.dart';
import 'package:cakeboss/frontend/custom_grid_view/src/widgets/staggered_grid_view.dart';
import 'package:cakeboss/frontend/custom_grid_view/src/widgets/staggered_tile.dart';
import 'package:cakeboss/frontend/src/charts/bar.dart';
import 'package:cakeboss/frontend/src/charts/time.dart';
import 'package:cakeboss/frontend/src/pages/sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'clientes_page.dart';
import 'domiciliarios_page.dart';
import 'example_view.dart';
import 'heatmap.dart';

class HomePage extends StatelessWidget {
  final Login login;
  final Sales sales;
  const HomePage({Key key, @required this.login, @required this.sales})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color mainColor = login.establishment.colors.primary.toColor();
    Color secondaryColor = login.establishment.colors.secondary.toColor();
    final size = MediaQuery.of(context).size;

    List<Widget> _tiles = <Widget>[
      const _CustomGridCard(
        title: 'Clientes',
        color: Colors.lightBlue,
        iconData: Icons.person_pin_circle,
        destino: ClientesPage(),
        valor: 200,
        meta: 400,
        subtitle: 'Total',
      ),
      _CustomGridCard(
        userLogin: login,
        sales: sales,
        title: 'Ventas',
        color: Colors.green,
        iconData: Icons.attach_money,
        destino: ClientesPage(),
        valor: 10542800,
        meta: 15542800,
        subtitle: 'Total',
      ),
      const _CustomGridCard(
        title: 'Estadisticas',
        color: Colors.amber,
        iconData: Icons.insert_chart,
        destino: null,
        valor: 1020,
        meta: 2020,
        subtitle: 'Facturas',
      ),
      const _CustomGridCard(
        title: 'Publicidad',
        color: Colors.brown,
        iconData: Icons.public,
        destino: null,
        valor: 1020,
        meta: 1203,
        subtitle: 'Alertas',
      ),
      const _CustomGridCard(
        title: 'Domiciliarios',
        color: Colors.deepOrange,
        iconData: Icons.send,
        destino: DomiciliariosPage(),
        valor: 4,
        meta: 10,
        subtitle: 'Activos',
      ),
      const _CustomGridCard(
        title: 'Mapa de calor',
        color: Colors.indigo,
        iconData: Icons.map,
        destino: HeathMapPage(),
        valor: 1,
        meta: 3,
        subtitle: 'Sedes',
      ),
    ];
    List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
      const StaggeredTile.count(4, 1.8),
      const StaggeredTile.count(2, 2),
      const StaggeredTile.count(2, 2),
      const StaggeredTile.count(2, 2),
      const StaggeredTile.count(2, 2),
      const StaggeredTile.count(2, 2),
    ];
    Color colorFondo = Colors.white;
    return BlocListener<DataBloc, DataState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        }
      },
      child: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          return state is SalesView
              ? SalesPage(
                  login: login,
                  state: state,
                  mainColor: mainColor,
                  secondaryColor: secondaryColor,
                )
              : Scaffold(
                  backgroundColor: colorFondo,
                  appBar: AppBar(
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          color: Colors.white),
                    ],
                    automaticallyImplyLeading: false,
                    backgroundColor: mainColor,
                    centerTitle: true,
                    title: Text(
                      'Gerentes',
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: StaggeredGridView.count(
                      crossAxisCount: 4,
                      staggeredTiles: _staggeredTiles,
                      children: _tiles,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      padding: const EdgeInsets.all(4.0),
                    ),
                  ),
                );
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        BlocProvider.of<LoginBloc>(context).add(LogOut(login.token));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Cerrar sesión"),
      content: Text("¿Realmente desea cerrar sesión? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _CustomGridCard extends StatelessWidget {
  const _CustomGridCard(
      {this.title,
      this.color,
      this.iconData,
      this.destino,
      this.valor,
      this.meta,
      this.subtitle,
      this.userLogin,
      this.sales});
  final Login userLogin;
  final Sales sales;
  final String title;
  final Color color;
  final IconData iconData;
  final Widget destino;
  final double valor;
  final double meta;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final formato = NumberFormat('#,###');
    final colorFondo = Colors.white;
    var colorContenido = color /*Color.fromRGBO(219, 202, 72, 1)*/;

    final customWidth02 =
        CustomSliderWidths(trackWidth: 1, progressBarWidth: 2);
    final customColors02 = CustomSliderColors(
        trackColor: Colors.grey,
        progressBarColor: colorContenido,
        hideShadow: true);

    final info02 = InfoProperties(
        topLabelStyle: TextStyle(
            color: colorContenido, fontSize: 22, fontWeight: FontWeight.w600),
        topLabelText: '$subtitle',
        bottomLabelStyle: TextStyle(
            color: Colors.grey,
            fontSize: title == 'Ventas' ? 10 : 14,
            fontWeight: FontWeight.w300),
        bottomLabelText: title == 'Ventas'
            ? 'Meta : \$${(formato.format(meta))}'
            : 'Meta : ${(formato.format(meta))}',
        mainLabelStyle: TextStyle(
            color: colorContenido,
            fontSize: title == 'Ventas' ? 20 : 24,
            fontWeight: FontWeight.w100),
        modifier: (double value) {
          final values = (valor).toInt();

          return title == 'Ventas'
              ? '\$${formato.format(values)}'
              : '${formato.format(values)}';
        });

    final CircularSliderAppearance appearance02 = CircularSliderAppearance(
      customWidths: customWidth02,
      customColors: customColors02,
      infoProperties: info02,
      startAngle: 180,
      angleRange: 270,
      spinnerDuration: 9000,
      animationEnabled: true,
    );
    final viewModel02 = ExampleViewModel(
        appearance: appearance02,
        min: 0,
        max: meta,
        value: valor,
        pageColors: [colorFondo, Colors.black87]);
    final example02 = ExamplePage(
      viewModel: viewModel02,
    );
    return Card(
      borderOnForeground: true,
      elevation: 8,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colorContenido,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8)),
      color: colorFondo,
      child: InkWell(
        onTap: () => BlocProvider.of<DataBloc>(context).add(ToSalesView()),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '$title',
                    style: TextStyle(
                        color: colorContenido,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Icon(
                      iconData,
                      color: colorContenido,
                      size: 80,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
