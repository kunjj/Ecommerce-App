import 'package:built_value/built_value.dart';
import 'package:ecommerce/api/home/product.dart';

import '../../core/enums.dart';

part 'cart_contract.g.dart';

abstract class CartData implements Built<CartData, CartDataBuilder> {
  factory CartData([void Function(CartDataBuilder) updates]) = _$CartData;

  CartData._();

  ScreenState get state;

  String? get errorMessage;

  List<Product> get products;

  num get totalAmount;
}

abstract class CartEvents {}

class InitCartEvent extends CartEvents {}

class UpdateCartEvent extends CartEvents {
  final CartData state;

  UpdateCartEvent(this.state);
}
