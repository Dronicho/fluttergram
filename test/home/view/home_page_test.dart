import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergram/modules/authentication/authentication.dart';
import 'package:fluttergram/modules/home/home.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationBloc extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

// ignore: must_be_immutable
class MockUser extends Mock implements User {
  @override
  String get email => 'test@gmail.com';
}

void main() {
  const logoutButtonKey = Key('homePage_logout_iconButton');

  setUpAll(() {
      registerFallbackValue<AuthenticationState>(AuthenticationState.unknown());
    });
  group('HomePage', () {
    late AuthenticationBloc authenticationBloc;
    late User user;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      user = MockUser();
      when(() => authenticationBloc.state).thenReturn(
        AuthenticationState.authenticated(user),
      );
    });

    group('calls', () {
      testWidgets('AuthenticationLogoutRequested when logout is pressed',
          (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        await tester.tap(find.byKey(logoutButtonKey));
        verify(() => 
          authenticationBloc.add(AuthenticationEvent.authenticationLogoutRequested()),
        ).called(1);
      });
    });

    group('renders', () {
      testWidgets('avatar widget', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        expect(find.byType(Avatar), findsOneWidget);
      });

      testWidgets('email address', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        expect(find.text('test@gmail.com'), findsOneWidget);
      });

      testWidgets('name', (tester) async {
        when(() => user.displayName).thenReturn('Joe');
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        expect(find.text('Joe'), findsOneWidget);
      });
    });
  });
}
