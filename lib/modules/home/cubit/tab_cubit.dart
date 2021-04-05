import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class TabCubit extends Cubit<int> {
  TabCubit({required TabController controller})
      : _controller = controller,
        super(0);
  final TabController _controller;

  void changePage(int index) {
    _controller.animateTo(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
