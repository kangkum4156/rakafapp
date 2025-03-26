import 'package:flutter/material.dart';
import 'package:rokafirst/login/login.dart';
import 'package:rokafirst/body/notice/notice_body.dart'; // NoticeBody import
import 'package:rokafirst/body/product/product_body.dart'; // ProductBody import
import 'package:rokafirst/body/waiting/waiting_body.dart'; // WaitingBody import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 현재 선택된 body를 관리할 변수
  Widget _currentBody = const ProductBody();

  // body를 변경하는 메서드
  void _updateBody(Widget newBody) {
    setState(() {
      _currentBody = newBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      drawer: HomeDrawer(onItemTap: _updateBody), // 드로어에 onItemTap 전달
      body: _currentBody, // 동적으로 body를 변경
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Roka First'),
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomeDrawer extends StatelessWidget {
  final Function(Widget) onItemTap; // onItemTap 콜백 함수

  const HomeDrawer({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.production_quantity_limits),
              title: const Text('Product'),
              onTap: () {
                onItemTap(const ProductBody()); // ProductBody로 전환
                Navigator.pop(context); // 드로어 닫기
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notice'),
              onTap: () {
                onItemTap(const NoticeBody()); // NoticeBody로 전환
                Navigator.pop(context); // 드로어 닫기
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Waiting'),
              onTap: () {
                onItemTap(const WaitingBody()); // WaitingBody로 전환
                Navigator.pop(context); // 드로어 닫기
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ); // 로그아웃 후 로그인 화면으로 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}