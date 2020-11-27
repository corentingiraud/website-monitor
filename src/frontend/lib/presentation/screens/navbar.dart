import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  Navbar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  MainBloc _mainBloc;
  WebsiteBloc _websiteBloc;

  @override
  void initState() {
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _websiteBloc = BlocProvider.of<WebsiteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        List<Widget> actions = [];
        if (state is MainConnected) {
          actions
            ..add(IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () =>
                  _websiteBloc.add(WebsiteRefreshed(state.password)),
            ))
            ..add(IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _mainBloc.add(MainLogout());
                Navigator.popAndPushNamed(context, '/');
              },
            ));
        }
        return AppBar(
          title: Text("MacoMonitor"),
          actions: actions,
        );
      },
    );
  }
}
