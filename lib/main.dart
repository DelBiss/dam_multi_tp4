
import 'package:dam_multi_tp4/screen/lock.dart';
import 'package:dam_multi_tp4/screen/temperature.dart';
import 'package:flutter/material.dart';

import 'PageTransition/rotating_page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData(
        
        pageTransitionsTheme: rotatingPageTransitionTheme) ,
      routes: {
        LockScreen.routeName: (context) =>  LockScreen(),
        TempScreen.routeName :(context) =>  TempScreen(),
      },
      initialRoute: LockScreen.routeName,
      
    );
  }
}
