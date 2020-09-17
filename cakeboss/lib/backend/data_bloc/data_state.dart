import 'dart:core';
import 'dart:ui';

import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:equatable/equatable.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

abstract class DataState extends Equatable {
  const DataState();
  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class Loading extends DataState {}

class Failure extends DataState {}

class Success extends DataState {}

class SalesView extends DataState {
  final formato = NumberFormat('#,###');
  final Login login;
  final Sales sales;
  DateTime beginDate;
  DateTime endDate;
  List<DayOrders> data;

  List<TicketDay> dataTicket2;

  List<StoreOrders> dataPedidosTiendaSelected = [];

  List<Products> dataProducts2 = [];

  List<charts.Series<StoreOrders, String>> dataPedidosTiendaCant() {
    return [
      charts.Series<StoreOrders, String>(
        id: 'Pedidos dia',
        data: dataPedidosTiendaSelected,
        domainFn: (StoreOrders pedido, __) => "Fecha: ${pedido.store} => Cant ",
        measureFn: (StoreOrders pedido, __) => pedido.amount,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            login.establishment.colors.primary.toColor()),
        labelAccessorFn: (StoreOrders pedido, _) =>
            '${pedido.store}: ${pedido.amount}',
      ),
    ];
  }

  List<charts.Series<StoreOrders, String>> dataPedidosTiendaVal() {
    return [
      charts.Series<StoreOrders, String>(
          id: 'Pedidos dia',
          data: dataPedidosTiendaSelected,
          domainFn: (StoreOrders pedido, __) =>
              "Fecha: ${pedido.store} => valor ",
          measureFn: (StoreOrders pedido, __) => pedido.value,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (StoreOrders pedido, _) =>
              '${pedido.store}: ${formato.format(pedido.value)}')
    ];
  }

  List<charts.Series<Strips, String>> dataFranjasCant() {
    return [
      charts.Series<Strips, String>(
        id: 'Franja horaria',
        data: sales.strips,
        domainFn: (Strips franja, __) => franja.type,
        measureFn: (Strips franja, __) => franja.amount,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            login.establishment.colors.primary.toColor()),
        labelAccessorFn: (Strips franaja, _) =>
            '${franaja.type}: ${franaja.amount}',
      )
    ];
  }

  List<charts.Series<Strips, String>> dataFranjasVal() {
    print(sales.strips);
    return [
      charts.Series<Strips, String>(
        id: 'Franja horaria',
        data: sales.strips,
        domainFn: (Strips franja, __) => franja.type,
        measureFn: (Strips franja, __) => franja.value,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            login.establishment.colors.primary.toColor()),
        labelAccessorFn: (Strips franaja, _) =>
            '${franaja.type}: ${formato.format(franaja.value)}',
      )
    ];
  }

  List<charts.Series<DayOrders, String>> dataPedidosDiaCant() {
    return [
      charts.Series<DayOrders, String>(
          id: 'Pedidos dia',
          data: data,
          domainFn: (DayOrders pedido, __) =>
              "Fecha: ${pedido.day.month}/${pedido.day.day} => Cant ",
          measureFn: (DayOrders pedido, __) => pedido.amount,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (DayOrders pedido, _) =>
              '${pedido.day.day}/${pedido.day.month}/${pedido.day.year}: ${pedido.amount}')
    ];
  }

  List<charts.Series<DayOrders, String>> dataPedidosDiaVal() {
    return [
      charts.Series<DayOrders, String>(
          id: 'Pedidos dia',
          data: data,
          domainFn: (DayOrders pedido, __) =>
              "Fecha: ${pedido.day.month}/${pedido.day.day} => valor ",
          measureFn: (DayOrders pedido, __) => pedido.value,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (DayOrders pedido, _) =>
              '${pedido.day.day}/${pedido.day.month}/${pedido.day.year}: ${formato.format(pedido.value)}')
    ];
  }

  List<charts.Series<DayOrders, DateTime>> dataPedidosDiaCantTime() {
    return [
      charts.Series<DayOrders, DateTime>(
        id: 'Pedidos dia',
        data: data,
        domainFn: (DayOrders pedido, __) => pedido.day,
        measureFn: (DayOrders pedido, __) => pedido.amount,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            login.establishment.colors.primary.toColor()),
      )
    ];
  }

  List<charts.Series<DayOrders, DateTime>> dataPedidosDiaValTime() {
    return [
      charts.Series<DayOrders, DateTime>(
        id: 'Pedidos dia',
        data: data,
        domainFn: (DayOrders pedido, __) => pedido.day,
        measureFn: (DayOrders pedido, __) => pedido.value,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            login.establishment.colors.primary.toColor()),
      )
    ];
  }

  List<charts.Series<TicketDay, String>> dataTicket() {
    return [
      charts.Series(
          id: 'TicketDay Promedio',
          data: dataTicket2,
          domainFn: (TicketDay ticket, __) =>
              "Fecha: ${ticket.day.month}/${ticket.day.day} => valor ",
          measureFn: (TicketDay ticket, __) => ticket.value,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (TicketDay ticket, _) =>
              '${ticket.day.day}/${ticket.day.month}/${ticket.day.year}: ${formato.format(ticket.value)}')
    ];
  }

  List<charts.Series<TicketStore, String>> dataTicketStore() {
    return [
      charts.Series(
          id: 'TicketStore Promedio',
          data: sales.ticketStore,
          domainFn: (TicketStore ticket, __) => "${ticket.store} => valor ",
          measureFn: (TicketStore ticket, __) => ticket.value,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (TicketStore ticket, _) =>
              '${ticket.store}: ${formato.format(ticket.value)}')
    ];
  }

  List<charts.Series<Products, String>> dataProductsCant() {
    return [
      charts.Series<Products, String>(
          id: 'Demanda productos',
          data: dataProducts2,
          domainFn: (Products product, __) => product.product,
          measureFn: (Products product, __) => product.amount,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (Products product, _) =>
              '${product.product}: ${formato.format(product.amount)}')
    ];
  }

  List<charts.Series<Products, String>> dataProductsVal() {
    return [
      charts.Series<Products, String>(
          id: 'Demanda productos',
          data: dataProducts2,
          domainFn: (Products product, __) => product.product,
          measureFn: (Products product, __) => product.value,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              login.establishment.colors.primary.toColor()),
          labelAccessorFn: (Products product, _) =>
              '${product.product}: ${formato.format(product.value)}')
    ];
  }

  List<charts.Series<DeliveriesAfterHours, DateTime>>
      dataDeliveriesAfterHours() {
    return [
      new charts.Series<DeliveriesAfterHours, DateTime>(
        id: 'Sales',
        data: sales.deliveriesAfterHours,
        domainFn: (DeliveriesAfterHours delivery, _) => delivery.day,
        measureFn: (DeliveriesAfterHours delivery, _) => delivery.value,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      )
    ];
  }

  SalesView({
    @required this.login,
    @required this.sales,
    @required this.beginDate,
    @required this.endDate,
  });
}
