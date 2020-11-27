import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/data/WebsiteRepositoryImpl.dart';
import 'package:maco_monitor/presentation/screens/home.dart';
import 'package:maco_monitor/presentation/screens/navbar.dart';
import 'package:maco_monitor/presentation/screens/websites.dart';

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          throw Error();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildApp() {
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
