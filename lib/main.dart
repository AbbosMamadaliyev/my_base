import 'package:flutter/material.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:my_base/ui/input_data_page/input_data_page_model.dart';
import 'package:provider/provider.dart';

import 'app/my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => HomePageModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => InputDataPageModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
