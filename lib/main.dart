import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di.dart';
import 'src/core/view.dart';
import 'src/model/state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  var di = await Graph.setup();
  final MyDexStore store = di.get();
  runApp(AppView().storeProvider(store));
}
