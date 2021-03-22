import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergram/modules/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fluttergram/modules/home/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state
        .maybeMap(authenticated: (value) => value.user, orElse: () => null));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationEvent.authenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user?.photoURL),
            const SizedBox(height: 4.0),
            Text(user?.email ?? '', style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user?.displayName ?? '', style: textTheme.headline5),
          ],
        ),
      ),
    );
  }
}
