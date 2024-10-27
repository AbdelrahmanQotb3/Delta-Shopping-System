import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Database/sqlDB.dart';
import 'Screens/home_page.dart';
import 'Screens/purchaseScreen.dart';
import 'Screens/splash_screen.dart';


void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    ChangeNotifierProvider(
      create: (context) => sqlDataBase(), // Provide the instance of sqlDataBase
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shopping System",
      routes: {
        SplashScreen.routeName : (_) => SplashScreen(),
        HomePage.routeName : (_) => HomePage(),
        purchaseScreen.routeName: (_) => purchaseScreen(),
      },
      initialRoute: HomePage.routeName,

    );
  }
}
