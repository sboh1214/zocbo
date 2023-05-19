import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/pages/auth_page.dart';
import 'package:zocbo/pages/search_page.dart';
import 'package:zocbo/services/auth_service.dart';

import 'services/info_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AuthService appService;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isLogined =
        context.select<InfoService, bool>((model) => model.hasData);

    final GoRouter _goRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/auth',
            builder: (context, state) => const AuthPage(),
          ),
        ],
        redirect: (BuildContext context, GoRouterState state) {
          if (!isLogined) {
            return '/auth';
          } else {
            return null;
          }
        });

    return MaterialApp.router(
        title: "Zocbo",
        routerConfig: _goRouter,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true));
  }
}