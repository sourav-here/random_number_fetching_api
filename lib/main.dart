import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_num_api/home_page.dart';
import 'package:random_num_api/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RandomNumberProvider(),
      child: MaterialApp(
        title: 'Random Number Generator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
