// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PreferencesState extends PreferencesState {
  @override
  final bool showNsfw;

  factory _$PreferencesState(
          [void Function(PreferencesStateBuilder) updates]) =>
      (new PreferencesStateBuilder()..update(updates)).build();

  _$PreferencesState._({this.showNsfw}) : super._() {
    if (showNsfw == null) {
      throw new BuiltValueNullFieldError('PreferencesState', 'showNsfw');
    }
  }

  @override
  PreferencesState rebuild(void Function(PreferencesStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreferencesStateBuilder toBuilder() =>
      new PreferencesStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreferencesState && showNsfw == other.showNsfw;
  }

  @override
  int get hashCode {
    return $jf($jc(0, showNsfw.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreferencesState')
          ..add('showNsfw', showNsfw))
        .toString();
  }
}

class PreferencesStateBuilder
    implements Builder<PreferencesState, PreferencesStateBuilder> {
  _$PreferencesState _$v;

  bool _showNsfw;
  bool get showNsfw => _$this._showNsfw;
  set showNsfw(bool showNsfw) => _$this._showNsfw = showNsfw;

  PreferencesStateBuilder();

  PreferencesStateBuilder get _$this {
    if (_$v != null) {
      _showNsfw = _$v.showNsfw;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreferencesState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PreferencesState;
  }

  @override
  void update(void Function(PreferencesStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreferencesState build() {
    final _$result = _$v ?? new _$PreferencesState._(showNsfw: showNsfw);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
