// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'register.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RegisterActionTearOff {
  const _$RegisterActionTearOff();

  NameTextChanged nameTextChanged(String name) {
    return NameTextChanged(
      name,
    );
  }

  EmailTextChanged emailTextChanged(String email) {
    return EmailTextChanged(
      email,
    );
  }

  PasswordTextChanged passwordTextChanged(String password) {
    return PasswordTextChanged(
      password,
    );
  }

  ErrorsChanged errorsChanged(String key, String? error) {
    return ErrorsChanged(
      key,
      error,
    );
  }
}

/// @nodoc
const $RegisterAction = _$RegisterActionTearOff();

/// @nodoc
mixin _$RegisterAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameTextChanged,
    required TResult Function(String email) emailTextChanged,
    required TResult Function(String password) passwordTextChanged,
    required TResult Function(String key, String? error) errorsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameTextChanged value) nameTextChanged,
    required TResult Function(EmailTextChanged value) emailTextChanged,
    required TResult Function(PasswordTextChanged value) passwordTextChanged,
    required TResult Function(ErrorsChanged value) errorsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterActionCopyWith<$Res> {
  factory $RegisterActionCopyWith(
          RegisterAction value, $Res Function(RegisterAction) then) =
      _$RegisterActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$RegisterActionCopyWithImpl<$Res>
    implements $RegisterActionCopyWith<$Res> {
  _$RegisterActionCopyWithImpl(this._value, this._then);

  final RegisterAction _value;
  // ignore: unused_field
  final $Res Function(RegisterAction) _then;
}

/// @nodoc
abstract class $NameTextChangedCopyWith<$Res> {
  factory $NameTextChangedCopyWith(
          NameTextChanged value, $Res Function(NameTextChanged) then) =
      _$NameTextChangedCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$NameTextChangedCopyWithImpl<$Res>
    extends _$RegisterActionCopyWithImpl<$Res>
    implements $NameTextChangedCopyWith<$Res> {
  _$NameTextChangedCopyWithImpl(
      NameTextChanged _value, $Res Function(NameTextChanged) _then)
      : super(_value, (v) => _then(v as NameTextChanged));

  @override
  NameTextChanged get _value => super._value as NameTextChanged;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(NameTextChanged(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NameTextChanged
    with DiagnosticableTreeMixin
    implements NameTextChanged {
  const _$NameTextChanged(this.name);

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegisterAction.nameTextChanged(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegisterAction.nameTextChanged'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NameTextChanged &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  $NameTextChangedCopyWith<NameTextChanged> get copyWith =>
      _$NameTextChangedCopyWithImpl<NameTextChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameTextChanged,
    required TResult Function(String email) emailTextChanged,
    required TResult Function(String password) passwordTextChanged,
    required TResult Function(String key, String? error) errorsChanged,
  }) {
    return nameTextChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
  }) {
    return nameTextChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
    required TResult orElse(),
  }) {
    if (nameTextChanged != null) {
      return nameTextChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameTextChanged value) nameTextChanged,
    required TResult Function(EmailTextChanged value) emailTextChanged,
    required TResult Function(PasswordTextChanged value) passwordTextChanged,
    required TResult Function(ErrorsChanged value) errorsChanged,
  }) {
    return nameTextChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
  }) {
    return nameTextChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
    required TResult orElse(),
  }) {
    if (nameTextChanged != null) {
      return nameTextChanged(this);
    }
    return orElse();
  }
}

abstract class NameTextChanged implements RegisterAction {
  const factory NameTextChanged(String name) = _$NameTextChanged;

  String get name;
  @JsonKey(ignore: true)
  $NameTextChangedCopyWith<NameTextChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailTextChangedCopyWith<$Res> {
  factory $EmailTextChangedCopyWith(
          EmailTextChanged value, $Res Function(EmailTextChanged) then) =
      _$EmailTextChangedCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class _$EmailTextChangedCopyWithImpl<$Res>
    extends _$RegisterActionCopyWithImpl<$Res>
    implements $EmailTextChangedCopyWith<$Res> {
  _$EmailTextChangedCopyWithImpl(
      EmailTextChanged _value, $Res Function(EmailTextChanged) _then)
      : super(_value, (v) => _then(v as EmailTextChanged));

  @override
  EmailTextChanged get _value => super._value as EmailTextChanged;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(EmailTextChanged(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailTextChanged
    with DiagnosticableTreeMixin
    implements EmailTextChanged {
  const _$EmailTextChanged(this.email);

  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegisterAction.emailTextChanged(email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegisterAction.emailTextChanged'))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmailTextChanged &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  $EmailTextChangedCopyWith<EmailTextChanged> get copyWith =>
      _$EmailTextChangedCopyWithImpl<EmailTextChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameTextChanged,
    required TResult Function(String email) emailTextChanged,
    required TResult Function(String password) passwordTextChanged,
    required TResult Function(String key, String? error) errorsChanged,
  }) {
    return emailTextChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
  }) {
    return emailTextChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
    required TResult orElse(),
  }) {
    if (emailTextChanged != null) {
      return emailTextChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameTextChanged value) nameTextChanged,
    required TResult Function(EmailTextChanged value) emailTextChanged,
    required TResult Function(PasswordTextChanged value) passwordTextChanged,
    required TResult Function(ErrorsChanged value) errorsChanged,
  }) {
    return emailTextChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
  }) {
    return emailTextChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
    required TResult orElse(),
  }) {
    if (emailTextChanged != null) {
      return emailTextChanged(this);
    }
    return orElse();
  }
}

abstract class EmailTextChanged implements RegisterAction {
  const factory EmailTextChanged(String email) = _$EmailTextChanged;

  String get email;
  @JsonKey(ignore: true)
  $EmailTextChangedCopyWith<EmailTextChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordTextChangedCopyWith<$Res> {
  factory $PasswordTextChangedCopyWith(
          PasswordTextChanged value, $Res Function(PasswordTextChanged) then) =
      _$PasswordTextChangedCopyWithImpl<$Res>;
  $Res call({String password});
}

/// @nodoc
class _$PasswordTextChangedCopyWithImpl<$Res>
    extends _$RegisterActionCopyWithImpl<$Res>
    implements $PasswordTextChangedCopyWith<$Res> {
  _$PasswordTextChangedCopyWithImpl(
      PasswordTextChanged _value, $Res Function(PasswordTextChanged) _then)
      : super(_value, (v) => _then(v as PasswordTextChanged));

  @override
  PasswordTextChanged get _value => super._value as PasswordTextChanged;

  @override
  $Res call({
    Object? password = freezed,
  }) {
    return _then(PasswordTextChanged(
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordTextChanged
    with DiagnosticableTreeMixin
    implements PasswordTextChanged {
  const _$PasswordTextChanged(this.password);

  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegisterAction.passwordTextChanged(password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegisterAction.passwordTextChanged'))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PasswordTextChanged &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  $PasswordTextChangedCopyWith<PasswordTextChanged> get copyWith =>
      _$PasswordTextChangedCopyWithImpl<PasswordTextChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameTextChanged,
    required TResult Function(String email) emailTextChanged,
    required TResult Function(String password) passwordTextChanged,
    required TResult Function(String key, String? error) errorsChanged,
  }) {
    return passwordTextChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
  }) {
    return passwordTextChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
    required TResult orElse(),
  }) {
    if (passwordTextChanged != null) {
      return passwordTextChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameTextChanged value) nameTextChanged,
    required TResult Function(EmailTextChanged value) emailTextChanged,
    required TResult Function(PasswordTextChanged value) passwordTextChanged,
    required TResult Function(ErrorsChanged value) errorsChanged,
  }) {
    return passwordTextChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
  }) {
    return passwordTextChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
    required TResult orElse(),
  }) {
    if (passwordTextChanged != null) {
      return passwordTextChanged(this);
    }
    return orElse();
  }
}

abstract class PasswordTextChanged implements RegisterAction {
  const factory PasswordTextChanged(String password) = _$PasswordTextChanged;

  String get password;
  @JsonKey(ignore: true)
  $PasswordTextChangedCopyWith<PasswordTextChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorsChangedCopyWith<$Res> {
  factory $ErrorsChangedCopyWith(
          ErrorsChanged value, $Res Function(ErrorsChanged) then) =
      _$ErrorsChangedCopyWithImpl<$Res>;
  $Res call({String key, String? error});
}

/// @nodoc
class _$ErrorsChangedCopyWithImpl<$Res>
    extends _$RegisterActionCopyWithImpl<$Res>
    implements $ErrorsChangedCopyWith<$Res> {
  _$ErrorsChangedCopyWithImpl(
      ErrorsChanged _value, $Res Function(ErrorsChanged) _then)
      : super(_value, (v) => _then(v as ErrorsChanged));

  @override
  ErrorsChanged get _value => super._value as ErrorsChanged;

  @override
  $Res call({
    Object? key = freezed,
    Object? error = freezed,
  }) {
    return _then(ErrorsChanged(
      key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorsChanged with DiagnosticableTreeMixin implements ErrorsChanged {
  const _$ErrorsChanged(this.key, this.error);

  @override
  final String key;
  @override
  final String? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegisterAction.errorsChanged(key: $key, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegisterAction.errorsChanged'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorsChanged &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $ErrorsChangedCopyWith<ErrorsChanged> get copyWith =>
      _$ErrorsChangedCopyWithImpl<ErrorsChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameTextChanged,
    required TResult Function(String email) emailTextChanged,
    required TResult Function(String password) passwordTextChanged,
    required TResult Function(String key, String? error) errorsChanged,
  }) {
    return errorsChanged(key, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
  }) {
    return errorsChanged?.call(key, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameTextChanged,
    TResult Function(String email)? emailTextChanged,
    TResult Function(String password)? passwordTextChanged,
    TResult Function(String key, String? error)? errorsChanged,
    required TResult orElse(),
  }) {
    if (errorsChanged != null) {
      return errorsChanged(key, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameTextChanged value) nameTextChanged,
    required TResult Function(EmailTextChanged value) emailTextChanged,
    required TResult Function(PasswordTextChanged value) passwordTextChanged,
    required TResult Function(ErrorsChanged value) errorsChanged,
  }) {
    return errorsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
  }) {
    return errorsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameTextChanged value)? nameTextChanged,
    TResult Function(EmailTextChanged value)? emailTextChanged,
    TResult Function(PasswordTextChanged value)? passwordTextChanged,
    TResult Function(ErrorsChanged value)? errorsChanged,
    required TResult orElse(),
  }) {
    if (errorsChanged != null) {
      return errorsChanged(this);
    }
    return orElse();
  }
}

abstract class ErrorsChanged implements RegisterAction {
  const factory ErrorsChanged(String key, String? error) = _$ErrorsChanged;

  String get key;
  String? get error;
  @JsonKey(ignore: true)
  $ErrorsChangedCopyWith<ErrorsChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$RegisterStateTearOff {
  const _$RegisterStateTearOff();

  _RegisterState call(
      {String nameText = '',
      String emailText = '',
      String passwordText = '',
      Map<String, String?> errors = const {}}) {
    return _RegisterState(
      nameText: nameText,
      emailText: emailText,
      passwordText: passwordText,
      errors: errors,
    );
  }
}

/// @nodoc
const $RegisterState = _$RegisterStateTearOff();

/// @nodoc
mixin _$RegisterState {
  String get nameText => throw _privateConstructorUsedError;
  String get emailText => throw _privateConstructorUsedError;
  String get passwordText => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterStateCopyWith<RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res>;
  $Res call(
      {String nameText,
      String emailText,
      String passwordText,
      Map<String, String?> errors});
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  final RegisterState _value;
  // ignore: unused_field
  final $Res Function(RegisterState) _then;

  @override
  $Res call({
    Object? nameText = freezed,
    Object? emailText = freezed,
    Object? passwordText = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      nameText: nameText == freezed
          ? _value.nameText
          : nameText // ignore: cast_nullable_to_non_nullable
              as String,
      emailText: emailText == freezed
          ? _value.emailText
          : emailText // ignore: cast_nullable_to_non_nullable
              as String,
      passwordText: passwordText == freezed
          ? _value.passwordText
          : passwordText // ignore: cast_nullable_to_non_nullable
              as String,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc
abstract class _$RegisterStateCopyWith<$Res>
    implements $RegisterStateCopyWith<$Res> {
  factory _$RegisterStateCopyWith(
          _RegisterState value, $Res Function(_RegisterState) then) =
      __$RegisterStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String nameText,
      String emailText,
      String passwordText,
      Map<String, String?> errors});
}

/// @nodoc
class __$RegisterStateCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$RegisterStateCopyWith<$Res> {
  __$RegisterStateCopyWithImpl(
      _RegisterState _value, $Res Function(_RegisterState) _then)
      : super(_value, (v) => _then(v as _RegisterState));

  @override
  _RegisterState get _value => super._value as _RegisterState;

  @override
  $Res call({
    Object? nameText = freezed,
    Object? emailText = freezed,
    Object? passwordText = freezed,
    Object? errors = freezed,
  }) {
    return _then(_RegisterState(
      nameText: nameText == freezed
          ? _value.nameText
          : nameText // ignore: cast_nullable_to_non_nullable
              as String,
      emailText: emailText == freezed
          ? _value.emailText
          : emailText // ignore: cast_nullable_to_non_nullable
              as String,
      passwordText: passwordText == freezed
          ? _value.passwordText
          : passwordText // ignore: cast_nullable_to_non_nullable
              as String,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc

class _$_RegisterState with DiagnosticableTreeMixin implements _RegisterState {
  const _$_RegisterState(
      {this.nameText = '',
      this.emailText = '',
      this.passwordText = '',
      this.errors = const {}});

  @JsonKey()
  @override
  final String nameText;
  @JsonKey()
  @override
  final String emailText;
  @JsonKey()
  @override
  final String passwordText;
  @JsonKey()
  @override
  final Map<String, String?> errors;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegisterState(nameText: $nameText, emailText: $emailText, passwordText: $passwordText, errors: $errors)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegisterState'))
      ..add(DiagnosticsProperty('nameText', nameText))
      ..add(DiagnosticsProperty('emailText', emailText))
      ..add(DiagnosticsProperty('passwordText', passwordText))
      ..add(DiagnosticsProperty('errors', errors));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterState &&
            const DeepCollectionEquality().equals(other.nameText, nameText) &&
            const DeepCollectionEquality().equals(other.emailText, emailText) &&
            const DeepCollectionEquality()
                .equals(other.passwordText, passwordText) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nameText),
      const DeepCollectionEquality().hash(emailText),
      const DeepCollectionEquality().hash(passwordText),
      const DeepCollectionEquality().hash(errors));

  @JsonKey(ignore: true)
  @override
  _$RegisterStateCopyWith<_RegisterState> get copyWith =>
      __$RegisterStateCopyWithImpl<_RegisterState>(this, _$identity);
}

abstract class _RegisterState implements RegisterState {
  const factory _RegisterState(
      {String nameText,
      String emailText,
      String passwordText,
      Map<String, String?> errors}) = _$_RegisterState;

  @override
  String get nameText;
  @override
  String get emailText;
  @override
  String get passwordText;
  @override
  Map<String, String?> get errors;
  @override
  @JsonKey(ignore: true)
  _$RegisterStateCopyWith<_RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}
