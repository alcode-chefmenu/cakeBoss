import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

ThemeData themeData;

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with ChangeNotifier {
  AuthenticationBloc() : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState(event.user, event.sales);
    }
    if (event is LoggedInWithOutEmail) {
      yield* _mapLoggedInWithOutEmailToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      yield Unauthenticated();
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      Login user, Sales sales) async* {
    if (user.establishment.colors.primary != null) {
      yield Authenticated(user: user, sales: sales);
    } else {
      user.establishment.colors.primary = "#db071e";
      user.establishment.colors.secondary = "#006db5";
      yield Authenticated(user: user, sales: sales);
    }
  }

  Stream<AuthenticationState> _mapLoggedInWithOutEmailToState() async* {
    yield AuthenticatedWithOutEmail();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
  }
}
