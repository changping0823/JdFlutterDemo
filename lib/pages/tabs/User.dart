import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/Counter.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {final counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(title:Text('用户中心')),
      body: Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'You have pushed the button this many times:',
        ),
        Text(
          '${counter.count}',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.display1,
        ),
      ],
    )
        ),
      floatingActionButton:  FloatingActionButton(
      onPressed: () {
        Provider.of<Counter>(context, listen: false).increment();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
    );
  }
}