import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';

import '../view/auth/auth.dart';
import '../view/home/features/search.dart';
import '../view/home/features/settings.dart';
import '../view/home/home.dart';

part 'state.freezed.dart';

typedef MyDexStore = Store<MyDexState>;

@freezed
class MyDexState with _$MyDexState {
  const factory MyDexState({
    @Default(AuthState()) AuthState authState,
    @Default(HomeState()) HomeState homeState,
    @Default(SearchState()) SearchState searchState,
    @Default(SettingsState()) SettingsState settingsState,
  }) = _MyDexState;
}

class MyDexReducer {
  static Reducer<MyDexState> reduce = combineReducers<MyDexState>([
    clearSelector,
    authSelector,
    homeSelector,
    searchSelector,
    settingsSelector,
  ]);

  static var clearSelector = TypedReducer<MyDexState, ClearAction>((state, action) => //
      const MyDexState());

  static var authSelector = TypedReducer<MyDexState, AuthActions>((state, action) => //
      state.copyWith(authState: AuthReducer.reduce(state.authState, action)));

  static var homeSelector = TypedReducer<MyDexState, HomeAction>((state, action) => //
      state.copyWith(homeState: HomeReducer.reduce(state.homeState, action)));

  static var searchSelector = TypedReducer<MyDexState, SearchAction>((state, action) => //
      state.copyWith(searchState: SearchReducer.reduce(state.searchState, action)));

  static var settingsSelector = TypedReducer<MyDexState, SettingsAction>((state, action) => //
      state.copyWith(settingsState: SettingsReducer.reduce(state.settingsState, action)));
}

class ClearAction {}

extension StoreExt on Store<MyDexState> {
  void dispatchAll(List<dynamic> actions) => actions.forEach(this.dispatch);
}
