import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergram/modules/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fluttergram/modules/home/cubit/page_cubit.dart';
import 'package:fluttergram/modules/main/view/main_page.dart';

import 'camera_page.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state
        .maybeMap(authenticated: (value) => value.user, orElse: () => null));

    return Scaffold(
        body: BlocProvider(
      create: (context) => PageCubit(controller: _controller),
      child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          allowImplicitScrolling: false,
          children: [CameraPage(), MainPage()]),
    ));
  }
}
