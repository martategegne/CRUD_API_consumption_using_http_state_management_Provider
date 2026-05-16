import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'User Manager',

  theme: ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),

    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
  ),

  home: HomeScreen(),
);
  }
}
