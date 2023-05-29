import 'package:controle_financeiro/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:controle_financeiro/screens/login/login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cost');

  var box = Hive.box('cost');
  // box.clear();
  //print(box.values.toList());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Financeiro',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: "login",
      routes: {
        'home': (context) => const HomePage()
      },
      home: const LoginPage(),
    );
  }
}
