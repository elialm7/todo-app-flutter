import 'package:flutter/material.dart';
import 'package:flutter_todoapp/pages/HomePage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main()  async {
  
  await Hive.initFlutter();
  var box = await Hive.openBox("MyBox");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: HomePage(),
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.orange
        )
      );
  }
}
