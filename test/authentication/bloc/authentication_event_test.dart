// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergram/modules/authentication/authentication_bloc/authentication_bloc.dart';

void main() {
  group('AuthenticationEvent', () {
    group('LoggedOut', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationEvent.authenticationLogoutRequested(),
          AuthenticationEvent.authenticationLogoutRequested(),
        );
      });
    });

    group('AuthenticationUserChanged', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationEvent.authenticationUserChanged(null),
          AuthenticationEvent.authenticationUserChanged(null),
        );
      });
    });
  });
}
