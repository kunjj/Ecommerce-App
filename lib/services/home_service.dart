import 'dart:async';

import 'package:ecommerce/api/home/home_api.dart';
import 'package:ecommerce/api/home/product.dart';
import 'package:flutter_base_architecture_plugin/imports/api_imports.dart';

class HomeService {
  final HomeApi _homeApi;

  HomeService(this._homeApi);

  Future<ResponseEntity<ProductResponse>> getProducts() async =>
      await _homeApi.getProducts();

  final _productStreamController = StreamController<Product>.broadcast();

  void addProductToCart(Product product) =>
      _productStreamController.add(product);

  Stream<Product> get productStream => _productStreamController.stream;
}
