import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di.dart';
import 'src/core/types.dart';
import 'src/core/view.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  var di = await Graph.setup();
  final MyDexStore store = di.get();
  runApp(AppView().storeProvider(store));
}
