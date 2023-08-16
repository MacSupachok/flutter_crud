import 'package:flutter/material.dart';
import 'package:flutter_crud_test/src/routes.dart';
import 'package:flutter_crud_test/src/screens/view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      routes: AppRoute.all,
      home: const ViewPage(),
    );
  }
}
