import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk%202.dart';

void main() {
  group('Redux', () {
    test('state', () {
      expect(const MyDexState().toString().isNotEmpty, isTrue);
      expect(MyDexReducer.reduce(const MyDexState(), null), equals(const MyDexState()));
      expect(MyDexReducer.reduce(devState(), null), equals(devState()));
      expect(MyDexReducer.reduce(devState(), ClearAction()), equals(const MyDexState()));
    });
    test('store', () {
      var store = Store<MyDexState>(MyDexReducer.reduce, initialState: const MyDexState(), middleware: [thunkMiddleware]);

      store.dispatch(const AuthAction.authChanged(true));
    });
  });
}
