import 'package:ecommerce/api/api_name.dart';
import 'package:ecommerce/api/api_response.dart';
import 'package:ecommerce/api/home/product.dart';

class HomeApi {
  final ApiClient _restApiClient;

  HomeApi(this._restApiClient);

  Future<ApiResponse<ProductResponse>> getProducts() async => await _restApiClient.get(path: Apis.getProducts).then((response) =>
      response.isSuccess ? ApiResponse.success(ProductResponse.fromJson(response.data)) : ApiResponse.error(response.errorMessage!));
}
