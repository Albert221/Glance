// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddits_search_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubredditsSearchState extends SubredditsSearchState {
  @override
  final String lastQuery;
  @override
  final BuiltList<String> resultFeedsIds;

  factory _$SubredditsSearchState(
          [void Function(SubredditsSearchStateBuilder) updates]) =>
      (new SubredditsSearchStateBuilder()..update(updates)).build();

  _$SubredditsSearchState._({this.lastQuery, this.resultFeedsIds}) : super._() {
    if (lastQuery == null) {
      throw new BuiltValueNullFieldError('SubredditsSearchState', 'lastQuery');
    }
    if (resultFeedsIds == null) {
      throw new BuiltValueNullFieldError(
          'SubredditsSearchState', 'resultFeedsIds');
    }
  }

  @override
  SubredditsSearchState rebuild(
          void Function(SubredditsSearchStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditsSearchStateBuilder toBuilder() =>
      new SubredditsSearchStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditsSearchState &&
        lastQuery == other.lastQuery &&
        resultFeedsIds == other.resultFeedsIds;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, lastQuery.hashCode), resultFeedsIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditsSearchState')
          ..add('lastQuery', lastQuery)
          ..add('resultFeedsIds', resultFeedsIds))
        .toString();
  }
}

class SubredditsSearchStateBuilder
    implements Builder<SubredditsSearchState, SubredditsSearchStateBuilder> {
  _$SubredditsSearchState _$v;

  String _lastQuery;
  String get lastQuery => _$this._lastQuery;
  set lastQuery(String lastQuery) => _$this._lastQuery = lastQuery;

  ListBuilder<String> _resultFeedsIds;
  ListBuilder<String> get resultFeedsIds =>
      _$this._resultFeedsIds ??= new ListBuilder<String>();
  set resultFeedsIds(ListBuilder<String> resultFeedsIds) =>
      _$this._resultFeedsIds = resultFeedsIds;

  SubredditsSearchStateBuilder();

  SubredditsSearchStateBuilder get _$this {
    if (_$v != null) {
      _lastQuery = _$v.lastQuery;
      _resultFeedsIds = _$v.resultFeedsIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditsSearchState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditsSearchState;
  }

  @override
  void update(void Function(SubredditsSearchStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditsSearchState build() {
    _$SubredditsSearchState _$result;
    try {
      _$result = _$v ??
          new _$SubredditsSearchState._(
              lastQuery: lastQuery, resultFeedsIds: resultFeedsIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'resultFeedsIds';
        resultFeedsIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubredditsSearchState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
