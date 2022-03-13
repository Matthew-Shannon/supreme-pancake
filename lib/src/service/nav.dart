import 'package:flutter/material.dart';

abstract class INav {
  void Function() goTo(BuildContext context, String key);
  void Function() goBack(BuildContext context);
  Widget getBy(String key);
  Widget selectInitial(bool status);
}

class Nav implements INav {
  final Map<String, Widget Function()> factories;
  final String authedViewName;
  final String unAuthedViewName;
  final String msg = 'View Not Found';

  Nav(this.authedViewName, this.unAuthedViewName, this.factories);

  @override
  void Function() goBack(BuildContext context) => //
      () => Navigator.pop(context);

  @override
  void Function() goTo(BuildContext context, String key) => //
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => getBy(key)));

  @override
  Widget getBy(String key) => factories[key] == null //
      ? Center(child: Text(msg))
      : factories[key]!();

  @override
  Widget selectInitial(bool status) => status //
      ? getBy(authedViewName)
      : getBy(unAuthedViewName);
}
