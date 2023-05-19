import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/models/lecture.dart';
import 'package:zocbo/services/info_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<InfoService>().user;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("프로그래밍 기초"),
      ),
      body: SafeArea(bottom: false, top: false, child: Text("data")),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          NavigationDrawerDestination(
            label: Text("${user.lastName}${user.firstName}"),
            icon: const Icon(Icons.abc),
          ),
          const NavigationDrawerDestination(
            label: Text("족보 열람"),
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              '수강중인 과목',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...user.myTimetableLectures
              .where((lecture) => lecture.year == 2023 && lecture.semester == 1)
              .map(
            (Lecture lecture) {
              return NavigationDrawerDestination(
                label: Text(lecture.title),
                icon: const Icon(Icons.class_outlined),
                selectedIcon: const Icon(Icons.class_),
              );
            },
          ),
        ],
      ),
    );
  }
}
