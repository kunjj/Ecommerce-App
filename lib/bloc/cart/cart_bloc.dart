import 'package:ecommerce/services/home_service.dart';
import 'package:flutter_base_architecture_plugin/core/base_bloc.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';

import 'cart_contract.dart';

class CartBloc extends BaseBloc<CartEvents, CartData> {
  CartBloc(this._homeService) : super(initState) {
    on<InitCartEvent>(_initCartEvent);
    on<UpdateCartEvent>((event, emit) => emit(event.state));
    _observeProductChange();
  }

  final HomeService _homeService;

  static CartData get initState => (CartDataBuilder()
        ..state = ScreenState.loading
        ..products = []
        ..errorMessage = '')
      .build();

  void _initCartEvent(_, __) {}

  void _observeProductChange() => _homeService.productStream.listen((product) {
        add(UpdateCartEvent(state.rebuild((updates) => updates
          ..state = ScreenState.content
          ..products?.add(product))));
      });
}
