import 'package:ecommerce/services/home_service.dart';
import 'package:flutter_base_architecture_plugin/core/base_bloc.dart';
import 'package:flutter_base_architecture_plugin/core/logging.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';

import 'cart_contract.dart';

class CartBloc extends BaseBloc<CartEvents, CartData> {
  CartBloc(this._homeService) : super(initState) {
    on<InitCartEvent>(_initCartEvent);
    on<UpdateCartEvent>((event, emit) => emit(event.state));
    on<RemoveProductEvent>(_removeProductEvent);
  }

  final HomeService _homeService;

  static CartData get initState => (CartDataBuilder()
        ..state = ScreenState.content
        ..products = []
        ..errorMessage = '')
      .build();

  void _initCartEvent(_, __) =>
      add(UpdateCartEvent(state.rebuild((updates) => updates
        ..state = _homeService.products.isEmpty
            ? ScreenState.empty
            : ScreenState.content
        ..products = _homeService.products)));

  void _removeProductEvent(RemoveProductEvent event, __) {
  //   _homeService.removeSelectedProduct(event.product);
  //   add(UpdateCartEvent(state.rebuild((updates) => updates
  //     ..products = _homeService.selectedProducts)));
  //   printLog(message: state.products.length);
  //   printLog(message: _homeService.selectedProducts.length);
  }

}
