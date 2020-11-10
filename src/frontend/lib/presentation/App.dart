import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/Dependencies.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/presentation/screens/home.dart';
import 'package:maco_monitor/presentation/screens/navbar.dart';

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
      home: BlocProvider(
        create: (context) => WebsiteBloc(dependencies.websiteRepository)
          ..add(WebsiteRefreshed()),
        child: Scaffold(
          appBar: Navbar(),
          body: Home(),
        ),
      ),
    );
  }
}
