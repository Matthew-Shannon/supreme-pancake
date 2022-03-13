import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:flutter/material.dart' hide Action, State, Listener;
export 'package:flutter_mobx/flutter_mobx.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get_it_mixin/get_it_mixin.dart';
export 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
export 'package:mobx/mobx.dart' hide version, Listenable, when;

class View {
  static Widget action(String id, IconData icon, void onClick()) => //
      Icon(icon, key: Key(id)) //
          .onTap(onClick)
          .padding(12.w.onlyEnd());

  static Widget singleCard(List<Widget> children) => children //
      .column()
      .paddingN(l: 24.r, t: 24.r, r: 24.r, b: 12.r)
      .card()
      .container(width: 1.2.sw)
      .padding(0.04.sh.onlyTop());

  static Widget frame(List<Widget> children) => children
      .column() //
      .padding(16.r.all())
      .sizedBox(width: double.infinity)
      .singleChildScrollView()
      .safeArea();
}

extension WidgetEx on Widget {
  Widget safeArea() => //
      SafeArea(child: this);

  Widget singleChildScrollView() => //
      SingleChildScrollView(child: this);

  Widget sizedBox({double? width, double? height}) => //
      SizedBox(width: width, height: height, child: this);

  Widget container({double? width, double? height, Key? key, Color? color}) => //
      Container(key: key, color: color, width: width, child: this);

  Widget center() => //
      Center(child: this);

  Widget onTap(void Function() onTap) => //
      GestureDetector(onTap: onTap, child: this);

  Widget outlinedButton(String id, void Function() onClick) => //
      OutlinedButton(key: Key(id), onPressed: onClick, child: this);

  Widget textButton(void Function() onClick) => //
      TextButton(onPressed: onClick, child: this);

  Widget elevatedButton(void Function() onClick) => //
      ElevatedButton(onPressed: onClick, child: this);

  Widget card([z = 8.0]) => //
      Card(elevation: z, child: this);

  PreferredSizeWidget appBar() => //
      AppBar(title: this, centerTitle: true);

  InputDecoration inputDecor(String? error) => //
      InputDecoration(label: this, errorText: error, border: const OutlineInputBorder());

  Widget padding(EdgeInsetsGeometry value) => //
      Padding(padding: value, child: this);

  Widget paddingN({l = 0.0, t = 0.0, r = 0.0, b = 0.0}) => //
      padding(EdgeInsets.fromLTRB(l, t, r, b));

  Widget switchListCell(bool value, void Function(bool) onChange) => //
      SwitchListTile(title: this, onChanged: onChange, value: value);
}

extension InputDecoratinoEx on InputDecoration {
  TextField textField(void Function(String) onChange, {isPassword = false}) => //
      TextField(decoration: this, obscureText: isPassword, onChanged: onChange);
}

extension WidgetExT on List<Widget> {
  Widget row({
    MainAxisAlignment align = MainAxisAlignment.start,
    MainAxisSize size = MainAxisSize.max,
  }) => //
      Row(
        mainAxisAlignment: align,
        mainAxisSize: size,
        children: this,
      );

  Widget column() => //
      Column(children: this);
}

extension doubleEx on double {
  EdgeInsets all() => EdgeInsets.all(this);
  EdgeInsets onlyTop() => EdgeInsets.only(top: this);
  EdgeInsets onlyEnd() => EdgeInsets.only(right: this);
  EdgeInsets onlyBottom() => EdgeInsets.only(bottom: this);
//EdgeInsets onlyStart() => EdgeInsets.only(left: this);
}
