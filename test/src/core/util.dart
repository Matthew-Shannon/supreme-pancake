import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

export 'package:dartz/dartz.dart' hide Evaluation;
export 'package:flutter/material.dart' hide State;
export 'package:flutter_test/flutter_test.dart';
export 'package:mocktail/mocktail.dart';

void expectAllExist(List<String> xs) => xs.forEach((x) => expect(find.text(x), findsOneWidget));
void expectKeysNotExist(List<String> xs) => xs.forEach((x) => expect(find.byKey(Key(x)), findsNothing));
void expectKeysExist(List<String> xs) => xs.forEach((x) => expect(find.byKey(Key(x)), findsOneWidget));

extension WhenExpectationEx on When {
  void thenCall<T>() => thenAnswer((_) => Future.value());
  void thenReply<T>(T t) => thenAnswer((_) => Future.value(t));
}

Response<Map<String, dynamic>> remoteResponse(Map<String, dynamic> data) => //
    Response(data: data, requestOptions: RequestOptions(path: ''));

extension TesterExt on WidgetTester {
  Future<void> inflate(Widget view) async => pumpWidget(MaterialApp(home: Material(child: view)));
  Future<void> inflateWithScaling(Widget Function() view) => pumpWidget(ScreenUtilInit(builder: () => MaterialApp(home: Material(child: view()))));
  Future<void> inflateWithNetwork(Widget Function() view) => mockNetworkImagesFor(() => inflateWithScaling(view));
}
