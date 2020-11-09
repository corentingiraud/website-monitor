import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maco_monitor/Dependencies.dart';

import 'home/HomeScreen.dart';

Dependencies _sharedDependencies;
Dependencies get dependencies => _sharedDependencies;

class App extends StatelessWidget {
  App({
    Key key,
    Dependencies dependencies,
  }) : super(key: key) {
    _sharedDependencies = dependencies;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MacoMonitor',
      theme: ThemeData(
        primaryColor: const Color(0xff1924ca),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('MacoMonitor'),
          ),
          body: HomeScreen()),
    );
  }
}
