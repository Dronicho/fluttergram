import 'package:flutter/material.dart';
import 'package:fluttergram/modules/home/cubit/page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feed_view.dart';
import 'profile_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fluttergram',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: TabBarView(
        children: [FeedView(), Container(), ProfileView()],
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          if (value == 1) {
            context.read<PageCubit>().changePage(0);
          } else {
            _tabController.animateTo(value);
            setState(() {
              _index = value;
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt), label: 'profile')
        ],
      ),
    );
  }
}
