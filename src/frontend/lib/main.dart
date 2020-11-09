import 'package:flutter/material.dart';

import 'Dependencies.dart';
import 'presentation/App.dart';

Future<void> main() async {
  final dependencies = Dependencies();

  runApp(App(
    dependencies: dependencies,
  ));
}
