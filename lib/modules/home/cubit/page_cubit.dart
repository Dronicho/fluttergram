import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PageCubit extends Cubit<int> {
  PageCubit({required PageController controller})
      : _controller = controller,
        super(0);
  final PageController _controller;

  void changePage(int index) {
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
