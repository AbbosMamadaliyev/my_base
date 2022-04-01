import 'package:flutter/material.dart';
import 'package:my_base/main_navigation.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:provider/provider.dart';

import '../ui/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();

    return MaterialApp(
      home: const FirstWidget(),
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
