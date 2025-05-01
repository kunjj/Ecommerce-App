import 'dart:async';

import 'package:ecommerce/api/api_response.dart';
import 'package:ecommerce/api/home/home_api.dart';
import 'package:ecommerce/api/home/product.dart';

class HomeService {
  final HomeApi _homeApi;
  List<Product> _products = [];

  HomeService(this._homeApi);

  Future<ApiResponse<ProductResponse>> getProducts() async =>
      await _homeApi.getProducts();

  set products(List<Product> products) => _products = products;

  List<Product> get products => _products;

  // List<Product> removeSelectedProduct(Product selectedProduct) {
  //   _selectedProducts
  //       .removeWhere((product) => product.id == selectedProduct.id);
  //   return _selectedProducts;
  // }
}
