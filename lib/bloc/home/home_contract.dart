import 'package:ecommerce/api/home/product.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

part 'home_contract.g.dart';

abstract class HomeData implements Built<HomeData, HomeDataBuilder> {
  factory HomeData([void Function(HomeDataBuilder) updates]) = _$HomeData;

  HomeData._();

  ScreenState get state;

  String? get errorMessage;

  List<Product> get products;

  String get searchQuery;
}

abstract class HomeEvents {}

class InitHomeEvent extends HomeEvents {}

class UpdateHomeEvent extends HomeEvents {
  final HomeData state;

  UpdateHomeEvent(this.state);
}

class GetProductsEvent extends HomeEvents {}

class AddProductToCartEvent extends HomeEvents {
  final Product product;

  AddProductToCartEvent({required this.product});
}

class SearchQueryChangeEvent extends HomeEvents {
  final String query;

  SearchQueryChangeEvent({required this.query});
}

class NavigateToCartScreenEvent extends HomeEvents {}
