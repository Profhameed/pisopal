import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/shared/app_pages.dart';
import 'package:inbestment/shared/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inbestment',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        colorScheme: kColorScheme,
        textTheme: kTextTheme,
      ),
      initialRoute: '/wrapperPage',
      getPages: AppPages.routes,
    );
  }
}
