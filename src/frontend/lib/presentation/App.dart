import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/data/WebsiteRepositoryImpl.dart';
import 'package:maco_monitor/presentation/screens/home.dart';
import 'package:maco_monitor/presentation/screens/navbar.dart';
import 'package:maco_monitor/presentation/screens/websites.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (BuildContext context) => MainBloc(),
        ),
        BlocProvider<WebsiteBloc>(
          create: (BuildContext context) => WebsiteBloc(
              websiteRepository: new WebsiteRepositoryImpl(),
              mainBloc: BlocProvider.of<MainBloc>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'MacoMonitor',
        theme: ThemeData(
          primaryColor: const Color(0xff1924ca),
          accentColor: const Color(0xffff6633),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
                appBar: Navbar(),
                body: Home(),
              ),
          '/websites': (context) => Scaffold(
                appBar: Navbar(),
                body: Websites(),
              ),
        },
      ),
    );
  }
}
