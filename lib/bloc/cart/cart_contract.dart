
import 'package:ecommerce/api/home/product.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

part 'cart_contract.g.dart';

abstract class CartData implements Built<CartData, CartDataBuilder> {
  factory CartData([void Function(CartDataBuilder) updates]) = _$CartData;

  CartData._();

  ScreenState get state;

  String? get errorMessage;

  List<Product> get products;
}

abstract class CartEvents {}

class InitCartEvent extends CartEvents {}

class UpdateCartEvent extends CartEvents {
  final CartData state;

  UpdateCartEvent(this.state);
}

class RemoveProductEvent extends CartEvents{
  final Product product;

  RemoveProductEvent({required this.product});
}