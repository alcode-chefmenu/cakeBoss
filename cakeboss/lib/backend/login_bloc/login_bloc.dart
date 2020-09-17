import 'package:cakeboss/backend/data/dataModel.dart';
import 'package:cakeboss/backend/service/interactor.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  @override
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithUserAndPassword) {
      yield* _mapLoginWithUserAndPasswordToState(
          user: event.user, password: event.password);
    }
    if (event is LogOut) {
      yield* _mapLogOutUserWithToken(token: event.token);
    }
  }

  Stream<LoginState> _mapLoginWithUserAndPasswordToState(
      {String user, String password}) async* {
    yield Loading();
    try {
      Login userLogin = await ServiceInteractor()
          .loginPost(Credentials(user: user, password: password));
      Sales sales = await ServiceInteractor().getSales();
      yield Success(userLogin, sales);
    } catch (e) {
      print(e);
      yield Failure();
    }
  }

  Stream<LoginState> _mapLogOutUserWithToken({String token}) async* {
    yield Loading();
    try {
      await ServiceInteractor().logoutDelete(token);
      yield LogOutSuccess();
    } catch (e) {
      yield Failure();
    }
  }
}
