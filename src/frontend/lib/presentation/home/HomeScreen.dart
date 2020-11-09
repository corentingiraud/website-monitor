import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/presentation/home/HomeBloc.dart';
import 'package:maco_monitor/presentation/home/HomeState.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: _bloc.getInitialState(),
        stream: _bloc.observeState(),
        builder: (context, snapshot) {
          return _buildUI(snapshot.data);
        });
  }

  Widget _buildUI(HomeState state) {
    return SafeArea(
      child: ListView(
        children: state.allWebsites == null
            ? []
            : List.generate(state.allWebsites.length, (index) {
                final website = state.allWebsites[index];
                return _buildListItem(website);
              }),
      ),
    );
  }

  Widget _buildListItem(Website website) {
    return ListTile(
      leading: Icon(Icons.web),
      title: Text(website.name),
      subtitle: Text(website.url),
      trailing: website.isUp
          ? Icon(Icons.check, color: Colors.green)
          : Icon(Icons.link_off, color: Colors.red),
    );
  }
}
