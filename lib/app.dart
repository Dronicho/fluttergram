import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergram/theme.dart';

import 'modules/authentication/authentication_bloc/authentication_bloc.dart';
import 'modules/home/view/home_page.dart';
import 'modules/login/login.dart';
import 'modules/splash/splash.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const App({Key? key, required this.authenticationRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
            authenticationRepository: authenticationRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            state.when(
              unknown: () {},
              authenticated: (user) {
                _navigator?.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              },
              unauthenticated: () {
                _navigator?.pushAndRemoveUntil<void>(
                  LoginPage?.route(),
                  (route) => false,
                );
              },
            );
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
