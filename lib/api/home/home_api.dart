import 'package:ecommerce/api/api_name.dart';
import 'package:ecommerce/api/home/product.dart';
import 'package:flutter_base_architecture_plugin/imports/api_imports.dart';

class HomeApi {
  final RestApiClient _restApiClient;

  HomeApi(this._restApiClient);

  Future<ResponseEntity<ProductResponse>> getProducts() async =>
      await _restApiClient
          .request(
              path: Apis.getProducts,
              data: RequestData(data: null, type: RequestDataType.body),
              requestMethod: RequestMethod.get)
          .then((response) => response.isSuccess
              ? ResponseEntity(ProductResponse.fromJson(response.data), null)
              : ResponseEntity(null, response.errorResult));
}
