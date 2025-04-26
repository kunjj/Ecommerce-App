// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_contract.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CartData extends CartData {
  @override
  final ScreenState state;
  @override
  final String? errorMessage;
  @override
  final List<Product> products;

  factory _$CartData([void Function(CartDataBuilder)? updates]) =>
      (new CartDataBuilder()..update(updates))._build();

  _$CartData._({required this.state, this.errorMessage, required this.products})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(state, r'CartData', 'state');
    BuiltValueNullFieldError.checkNotNull(products, r'CartData', 'products');
  }

  @override
  CartData rebuild(void Function(CartDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CartDataBuilder toBuilder() => new CartDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CartData &&
        state == other.state &&
        errorMessage == other.errorMessage &&
        products == other.products;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CartData')
          ..add('state', state)
          ..add('errorMessage', errorMessage)
          ..add('products', products))
        .toString();
  }
}

class CartDataBuilder implements Builder<CartData, CartDataBuilder> {
  _$CartData? _$v;

  ScreenState? _state;
  ScreenState? get state => _$this._state;
  set state(ScreenState? state) => _$this._state = state;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  List<Product>? _products;
  List<Product>? get products => _$this._products;
  set products(List<Product>? products) => _$this._products = products;

  CartDataBuilder();

  CartDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _errorMessage = $v.errorMessage;
      _products = $v.products;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CartData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CartData;
  }

  @override
  void update(void Function(CartDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CartData build() => _build();

  _$CartData _build() {
    final _$result = _$v ??
        new _$CartData._(
            state: BuiltValueNullFieldError.checkNotNull(
                state, r'CartData', 'state'),
            errorMessage: errorMessage,
            products: BuiltValueNullFieldError.checkNotNull(
                products, r'CartData', 'products'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
