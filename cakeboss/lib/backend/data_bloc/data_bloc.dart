import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:flutter/cupertino.dart';

import './bloc.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final Sales sales;
  final Login userLogin;
  DateTime beginDate;
  DateTime endDate;
  DataBloc({@required this.sales, @required this.userLogin})
      : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is ToSalesView) {
      yield* _mapToSalesView();
    }
  }

  Stream<DataState> _mapToSalesView() async* {
    try {
      print(sales);
      yield SalesView(
        sales: sales,
        login: userLogin,
        beginDate: beginDate,
        endDate: endDate,
      );
    } catch (e) {
      print(e);
    }
  }
}
