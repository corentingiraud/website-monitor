import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/domain/entity/Website.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebsiteBloc, WebsiteState>(
      builder: (context, state) {
        if (state is WebsiteInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WebsiteFailure) {
          return Center(
            child: Text('Failed to fetch Websites'),
          );
        }
        if (state is WebsiteLoading) {
          return Center(
            child: Text('Loading ...'),
          );
        }
        if (state is WebsiteSuccess) {
          if (state.websites.isEmpty) {
            return Center(
              child: Text('No Websites'),
            );
          }
          return ListView(
            children: List.generate(state.websites.length, (index) {
              final website = state.websites[index];
              return _buildListItem(website);
            }),
          );
        }
        return null;
      },
    );
  }

  Widget _buildListItem(Website website) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.web),
        ],
      ),
      title: Text(website.name),
      subtitle: Text(website.url),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          website.isUp
              ? Icon(Icons.check, color: Colors.green)
              : Icon(Icons.link_off, color: Colors.red),
          PopupMenuButton<String>(
            onSelected: null,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
