import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/domain/entity/Website.dart';

class Websites extends StatefulWidget {
  @override
  _WebsitesState createState() => _WebsitesState();
}

class _WebsitesState extends State<Websites> {
  MainBloc _mainBloc;
  @override
  void initState() {
    _mainBloc = BlocProvider.of<MainBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebsiteBloc, WebsiteState>(
        builder: (context, websiteState) {
      if (websiteState is WebsiteFailure) {
        if (websiteState.wrongPassword) {
          return _buildWrongPassword();
        }
        return Center(
          child: Text('Failed to fetch website'),
        );
      }
      if (websiteState is WebsiteLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (websiteState is WebsiteSuccess) {
        if (websiteState.websites.isEmpty) {
          return Center(
            child: Text('No Websites'),
          );
        }
        return ListView(
          children: List.generate(websiteState.websites.length, (index) {
            final website = websiteState.websites[index];
            return _buildListItem(website);
          }),
        );
      }
      return null;
    });
  }

  Widget _buildWrongPassword() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Mauvais mot de passe...'),
                const SizedBox(height: 30),
                OutlineButton(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  textColor: Theme.of(context).accentColor,
                  child: Text('Essayer de nouveau'),
                  onPressed: () {
                    _mainBloc.add(MainLogout());
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
      trailing: website.isUp
          ? Icon(Icons.check, color: Colors.green)
          : Icon(Icons.link_off, color: Colors.red),
    );
  }
}
