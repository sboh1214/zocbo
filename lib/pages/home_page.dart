import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/services/lecture_service.dart';
import '../models/exam.dart';
import '../models/lecture.dart';
import '../pages/course_page.dart';
import '../pages/search_page.dart';
import '../pages/user_page.dart';
import '../services/info_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 1;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
    if (selectedScreen > 1) {
      context.read<LectureService>().setLecture(selectedScreen - 2);
    }
    scaffoldKey.currentState!.closeDrawer();
  }

  List<Widget> _buildTabs(List<Exam> exams) {
    List<Widget> tabs = [];
    if (exams.any((exam) => exam.id == 'mid')) {
      tabs.add(const Tab(text: '중간고사'));
    }
    if (exams.any((exam) => exam.id == 'final')) {
      tabs.add(const Tab(text: '기말고사'));
    }
    if (exams.any((exam) => exam.id?.contains('quiz') ?? false)) {
      tabs.add(const Tab(text: '퀴즈'));
    }
    if (exams.any((exam) => exam.id?.contains('assignment') ?? false)) {
      tabs.add(const Tab(text: '과제'));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final user = context.read<InfoService>().user;
    final currentLectures = context.watch<LectureService>().lectures;
    final exams = context.watch<LectureService>().exams;

    return DefaultTabController(
      length: exams.length,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:
            screenIndex < 2 ? colorScheme.surfaceVariant : colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surfaceVariant,
          toolbarHeight: 64,
          centerTitle: true,
          title: screenIndex < 2
              ? Image.asset('assets/logo.png', height: 27)
              : Text(
                  currentLectures[screenIndex - 2].title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          flexibleSpace: SafeArea(
            child: Container(
              color: colorScheme.primary,
              height: 5,
            ),
          ),
          actions: screenIndex < 2
              ? null
              : [
                  PopupMenuButton(
                    child: FilledButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down, size: 16)
                        ],
                      ),
                    ),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text('Item 1'),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text('Item 2'),
                      ),
                      const PopupMenuItem<int>(
                        value: 3,
                        child: Text('Item 3'),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
          bottom: (screenIndex < 2 || exams.isEmpty)
              ? null
              : TabBar(
                  tabs: _buildTabs(exams),
                  onTap: (index) =>
                      {context.read<LectureService>().setExamIndex(index)},
                ),
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
              label: Text(
                "${user.firstName} ${user.lastName}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
            ),
            NavigationDrawerDestination(
              label: Text(
                "족보 열람",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              icon: const Icon(Icons.search_outlined),
              selectedIcon: const Icon(Icons.search),
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
                  label: Text(
                    lecture.title,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  icon: const Icon(Icons.navigate_next_outlined),
                  selectedIcon: const Icon(Icons.navigate_next),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
