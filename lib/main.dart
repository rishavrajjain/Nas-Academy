import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/customer_model.dart';
import 'page/home.dart';


void main() {
 runApp(
    ChangeNotifierProvider(
      create: (context) => CustomerModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nas Academy Application',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". 
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Customer List'),
    );
  }
}


