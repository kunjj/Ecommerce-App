import 'package:ecommerce/services/home_service.dart';
import 'package:flutter_base_architecture_plugin/core/base_bloc.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';

import 'cart_contract.dart';

class CartBloc extends BaseBloc<CartEvents, CartData> {
  CartBloc(this._homeService) : super(initState) {
    on<InitCartEvent>(_initCartEvent);
    on<UpdateCartEvent>((event, emit) => emit(event.state));
  }

  final HomeService _homeService;

  static CartData get initState => (CartDataBuilder()
        ..state = ScreenState.content
        ..products = []
        ..totalAmount = 0
        ..errorMessage = '')
      .build();

  void _initCartEvent(_, __) => add(UpdateCartEvent(state.rebuild((updates) => updates
    ..state = _homeService.products.isEmpty ? ScreenState.empty : ScreenState.content
    ..totalAmount = _homeService.products.where((product) => product.isSelected).fold(0.0, (total, product) => total! + product.price!)
    ..products = _homeService.products)));
}
