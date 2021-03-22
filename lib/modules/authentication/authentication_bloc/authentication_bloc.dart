import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<User?> _userSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(_Unknown()) {
    _userSubscription = _authenticationRepository.user
        .listen((user) => add(_AuthenticationUserChanged(user)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is _AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is _AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    _AuthenticationUserChanged event,
  ) {
    return event.user != null
        ? AuthenticationState.authenticated(event.user!)
        : const AuthenticationState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
