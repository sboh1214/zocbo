import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/models/lecture.dart';
import 'package:zocbo/pages/course_page.dart';
import 'package:zocbo/pages/search_page.dart';
import 'package:zocbo/pages/user_page.dart';
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
    scaffoldKey.currentState!.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<InfoService>().user;
    final currentLectures = user.myTimetableLectures
        .where((lecture) => lecture.year == 2023 && lecture.semester == 1)
        .toList();

    final title = screenIndex == 0
        ? user.lastName + user.firstName
        : screenIndex == 1
            ? "족보 열람"
            : currentLectures[screenIndex - 2].title;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        actions: [
          ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.calendar_today),
                  Icon(Icons.arrow_drop_down)
                ],
              ))
        ],
      ),
      body: screenIndex == 0
          ? const UserPage()
          : screenIndex == 1
              ? const SearchPage()
              : const CoursePage(),
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
          ...currentLectures.map(
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
