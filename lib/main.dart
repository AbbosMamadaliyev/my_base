import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_base/ui/edit_item_page/edit_item_page_model.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:my_base/ui/input_data_page/input_data_page_model.dart';
import 'package:my_base/ui/login_page/login_page_model.dart';
import 'package:my_base/ui/signup_page/signup_page_model.dart';
import 'package:my_base/ui/view_all_files/all_files_page_model.dart';
import 'package:my_base/ui/view_data_page/view_data_page_model.dart';
import 'package:provider/provider.dart';

import 'app/my_app.dart';
import 'domain/dataproviders/auth_service/auth_service.dart';
import 'domain/models/user.dart';
import 'main_navigation.dart';
//change
// chaine
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserModel userModel = UserModel();
  final mainNavigation = MainNavigation();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: AuthService().currentUser,
          initialData: userModel,
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => HomePageModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => InputDataPageModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ViewDataPageModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => EditItemPageModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => AllFilesPageModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SignInProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SignUpProvider()),
      ],
      child: MyApp(
        initialRoute: await mainNavigation.initialRoute(),
      ),
    ),
  );
}
