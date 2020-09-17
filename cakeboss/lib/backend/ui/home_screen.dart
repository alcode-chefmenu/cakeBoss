import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:cakeboss/backend/data_bloc/bloc.dart';
import 'package:cakeboss/frontend/src/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final Login login;
  final Sales sales;
  HomeScreen({Key key, @required this.login, @required this.sales})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      create: (context) => DataBloc(
        sales: sales,
        userLogin: login,
      ),
      child: HomePage(
        login: login,
        sales: sales,
      ),
    );
  }
}
