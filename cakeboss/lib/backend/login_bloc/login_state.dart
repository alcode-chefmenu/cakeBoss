import 'dart:ui';

import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:equatable/equatable.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

// Cuatro estados:
// - Cargando, loading
class Loading extends LoginState {}

// - Falla, failure
class Failure extends LoginState {}

// - Exito, success
class Success extends LoginState {
  final Login user;
  final Sales sales;
  Success(this.user, this.sales);
}

class LogOutSuccess extends LoginState {}

class HomeView extends LoginState {}

class ClientsView extends LoginState {}

class TicketView extends LoginState {}

class DomiciliaryView extends LoginState {}

class HeatMapView extends LoginState {}
