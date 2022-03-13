import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Graph.setup();
  runApp(AppView());
}
