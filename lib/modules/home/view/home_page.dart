import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergram/modules/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fluttergram/modules/home/view/cubit/page_cubit.dart';

final kDefaultRadius = 50.0;
final kSmallRadius = 35.0;

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

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('camera')),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

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
      body: ProfileView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          if (value == 1) {
            context.read<PageCubit>().changePage(0);
          } else {
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

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Text('Ivan Penis',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque consectetur nunc ac porttitor laoreet. Aliquam eget magna sollicitudin, tristique nisi in, lacinia tortor. Nullam faucibus turpis et ullamcorper aliquet'),

              ],
            ),
          )
        ],
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

class FeedView extends StatelessWidget {
  const FeedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child:
                    Row(children: List.generate(10, (index) => StoryWidget())),
              )),
          ...List.generate(10, (index) => PostCard())
        ],
      ),
    );
  }
}

class StoryWidget extends StatefulWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  bool _tapped = false;
  BoxConstraints _normalSize =
      BoxConstraints.loose(Size(kDefaultRadius, kDefaultRadius));
  BoxConstraints _shrinkSize =
      BoxConstraints.loose(Size(kSmallRadius, kSmallRadius));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _tapped = true;
        });
      },
      onLongPress: () {
        setState(() {
          _tapped = false;
        });
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.white),
        );
      },
      onTapUp: (details) {
        setState(() {
          _tapped = false;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            padding: _tapped ? const EdgeInsets.all(7.5) : EdgeInsets.zero,
            child: AnimatedContainer(
              padding: const EdgeInsets.all(4),
              constraints: _tapped ? _shrinkSize : _normalSize,
              duration: Duration(milliseconds: 50),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.lightGreen),
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                child: Center(child: Text('A')),
              ),
            ),
          ),
          Text('name')
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 4.0, top: 4.0, bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    child: Text('B'),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
            ],
          ),
        ),
        Image.network('https://source.unsplash.com/random'),
        Row(
          children: [
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(icon: Icon(Icons.comment), onPressed: () {}),
            IconButton(icon: Icon(Icons.bookmark), onPressed: () {}),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            '3124424 views',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: RichText(
            text: TextSpan(
              text: 'asus_russia ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                TextSpan(
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque consectetur nunc ac porttitor laoreet. Aliquam eget magna sollicitudin, tristique nisi in, lacinia tortor. Nullam faucibus turpis et ullamcorper aliquet. Morbi gravida, augue at volutpat venenatis, turpis magna ullamcorper libero, ut sagittis ex lorem at nulla. Donec at ipsum ac sapien tincidunt ullamcorper. Pellentesque vel rutrum quam. Donec non pellentesque lorem, id accumsan eros. Cras lobortis ligula viverra velit accumsan, nec condimentum nibh vulputate. Vestibulum nec risus sit amet enim tempus semper. Suspendisse eleifend dui eget est gravida euismod. Nullam maximus ante non nibh feugiat, vel pretium nulla facilisis. Nunc iaculis velit vel leo dignissim, a pharetra orci faucibus. Nunc ornare suscipit tempus.')
              ],
            ),
          ),
        )
      ],
    );
  }
}
