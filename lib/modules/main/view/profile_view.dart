import 'package:flutter/material.dart';
import 'package:fluttergram/modules/main/view/photos_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        body: TabBarView(children: [UserPhotosView(), UserPhotosView()]),
        headerSliverBuilder: (context, innerBoxIsScrolled) => ([
          SliverList(
              delegate: SliverChildListDelegate([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text('name'),
                ),
                ProfileDataTile(count: 10, title: 'Posts'),
                ProfileDataTile(count: 10, title: 'Followers'),
                ProfileDataTile(count: 10, title: 'Following'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Alex Penis',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque consectetur nunc ac porttitor laoreet. Aliquam eget magna sollicitudin, tristique nisi in, lacinia tortor. Nullam faucibus turpis et ullamcorper aliquet'),
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.apps, color: Colors.black)),
                Tab(
                    icon: Icon(Icons.assignment_ind_outlined,
                        color: Colors.black))
              ],
              indicatorColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 1.5,
            )
          ]))
        ]),
      ),
    );
  }
}

class ProfileDataTile extends StatelessWidget {
  final int count;
  final String title;

  const ProfileDataTile({Key? key, required this.count, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(title),
      ],
    );
  }
}
