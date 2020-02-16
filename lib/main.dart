import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routers/router.dart';
import 'Provider/Counter.dart';
import 'Provider/CartCounter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Counter()),
          ChangeNotifierProvider(create: (_) => CartCounter()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: onGenerateRouter,
          theme: ThemeData(primaryColor: Colors.white),
        ));
  }
}
