import 'package:ecommerce/core/enums.dart';
import 'package:ecommerce/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_contract.dart';

class CartBloc extends Bloc<CartEvents, CartData> {
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
    ..totalAmount = _homeService.products
        .where((product) => product.isSelected)
        .fold(0.0, (total, product) => total! + product.price!)
    ..products = _homeService.products)));
}
