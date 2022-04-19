import 'package:flutter/material.dart';
import 'package:my_base/main_navigation.dart';
import 'package:my_base/ui/example_page.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:provider/provider.dart';

import '../ui/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff0e0c0c),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff0e0c0c),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
            const Color(0xff0e0c0c),
          )),
        ),
      ),
      initialRoute: initialRoute,
      // home: const ExamplePage(),
      routes: mainNavigation.routes,
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageModel()),
      ],
      child: const MyHomePage(),
    );
  }
}
