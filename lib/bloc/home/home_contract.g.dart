// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_contract.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeData extends HomeData {
  @override
  final ScreenState state;
  @override
  final String? errorMessage;
  @override
  final List<Product> products;
  @override
  final String searchQuery;

  factory _$HomeData([void Function(HomeDataBuilder)? updates]) =>
      (new HomeDataBuilder()..update(updates))._build();

  _$HomeData._(
      {required this.state,
      this.errorMessage,
      required this.products,
      required this.searchQuery})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(state, r'HomeData', 'state');
    BuiltValueNullFieldError.checkNotNull(products, r'HomeData', 'products');
    BuiltValueNullFieldError.checkNotNull(
        searchQuery, r'HomeData', 'searchQuery');
  }

  @override
  HomeData rebuild(void Function(HomeDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeDataBuilder toBuilder() => new HomeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeData &&
        state == other.state &&
        errorMessage == other.errorMessage &&
        products == other.products &&
        searchQuery == other.searchQuery;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, searchQuery.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeData')
          ..add('state', state)
          ..add('errorMessage', errorMessage)
          ..add('products', products)
          ..add('searchQuery', searchQuery))
        .toString();
  }
}

class HomeDataBuilder implements Builder<HomeData, HomeDataBuilder> {
  _$HomeData? _$v;

  ScreenState? _state;
  ScreenState? get state => _$this._state;
  set state(ScreenState? state) => _$this._state = state;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  List<Product>? _products;
  List<Product>? get products => _$this._products;
  set products(List<Product>? products) => _$this._products = products;

  String? _searchQuery;
  String? get searchQuery => _$this._searchQuery;
  set searchQuery(String? searchQuery) => _$this._searchQuery = searchQuery;

  HomeDataBuilder();

  HomeDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _errorMessage = $v.errorMessage;
      _products = $v.products;
      _searchQuery = $v.searchQuery;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeData;
  }

  @override
  void update(void Function(HomeDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeData build() => _build();

  _$HomeData _build() {
    final _$result = _$v ??
        new _$HomeData._(
            state: BuiltValueNullFieldError.checkNotNull(
                state, r'HomeData', 'state'),
            errorMessage: errorMessage,
            products: BuiltValueNullFieldError.checkNotNull(
                products, r'HomeData', 'products'),
            searchQuery: BuiltValueNullFieldError.checkNotNull(
                searchQuery, r'HomeData', 'searchQuery'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
