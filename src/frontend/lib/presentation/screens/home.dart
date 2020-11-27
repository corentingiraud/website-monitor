import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/presentation/screens/websites.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MainBloc _mainBloc;
  final _passwordController = TextEditingController();
  bool _isPasswordFormValid = false;

  @override
  void initState() {
    super.initState();
    _isPasswordFormValid = false;
    _mainBloc = BlocProvider.of<MainBloc>(context);

    _passwordController.addListener(() {
      setState(() {
        _isPasswordFormValid = _passwordController.text != '' ? true : false;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                    controller: _passwordController,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                OutlineButton(
                  disabledBorderColor: Colors.grey,
                  disabledTextColor: Colors.grey,
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  highlightedBorderColor: Theme.of(context).accentColor,
                  textColor: Theme.of(context).accentColor,
                  child: Text('OK'),
                  onPressed: _isPasswordFormValid
                      ? () {
                          _mainBloc.add(
                              MainSubmitPassword(_passwordController.text));
                          Navigator.pushReplacementNamed(context, '/websites');
                        }
                      : null,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
