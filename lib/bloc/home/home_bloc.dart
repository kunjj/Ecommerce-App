import 'package:ecommerce/services/home_service.dart';
import 'package:flutter_base_architecture_plugin/core/base_bloc.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/core/view_actions.dart';

import '../../core/routes.dart';
import 'home_contract.dart';

class HomeBloc extends BaseBloc<HomeEvents, HomeData> {
  HomeBloc(this._homeService) : super(initState) {
    on<InitHomeEvent>(_initHomeEvent);
    on<UpdateHomeEvent>((event, emit) => emit(event.state));
    on<GetProductsEvent>(_getProductsEvent);
    on<AddProductToCartEvent>(_addProductToCartEvent);
    on<SearchQueryChangeEvent>(_searchQueryTextEvent);
    on<NavigateToCartScreenEvent>(_navigateToCartScreenEvent);
    on<RefreshProductEvent>(_refreshProductEvent);
  }

  final HomeService _homeService;

  static HomeData get initState => (HomeDataBuilder()
        ..state = ScreenState.loading
        ..searchQuery = ''
        ..products = []
        ..errorMessage = '')
      .build();

  void _initHomeEvent(_, __) => add(GetProductsEvent());

  void _getProductsEvent(_, __) async => await _homeService
      .getProducts()
      .then((response) {
        response.data != null
          ? add(UpdateHomeEvent(state.rebuild((updates) => updates
            ..products = response.data!.products
            ..state = ScreenState.content)))
          : add(UpdateHomeEvent(state.rebuild((updates) => updates
            ..state = ScreenState.error
            ..errorMessage = response.errorMessage ?? 'Something went wrong')));
        _homeService.products = state.products;
      })
      .catchError((error) => add(UpdateHomeEvent(state.rebuild((updates) => updates
        ..state = ScreenState.error
        ..errorMessage = error.toString()))));

  void _addProductToCartEvent(AddProductToCartEvent event, __) {
    var filteredProducts = state.products.map((product) {
      product.isSelected = product.id == event.product.id;
      return product;
    }).toList();

    _homeService.products = filteredProducts;

    add(UpdateHomeEvent(state.rebuild((updates) => updates
      ..products = filteredProducts)));
  }

  void _searchQueryTextEvent(SearchQueryChangeEvent event, _) {
    add(UpdateHomeEvent(state.rebuild((updates) => updates..state = ScreenState.loading)));

    var filteredProducts = state.products.map((product) {
      product.isSearchQueryMatched = product.title!.toLowerCase().contains(event.query.toLowerCase());
      return product;
    }).toList();

    add(UpdateHomeEvent(state.rebuild((updates) => updates
      ..state = ScreenState.content
      ..products = filteredProducts)));
  }

  void _navigateToCartScreenEvent(_, __) => dispatchViewEvent(NavigateScreen(AppRoutes.cartScreen));

  void _refreshProductEvent(RefreshProductEvent event, _) {
    add(UpdateHomeEvent(state.rebuild((updates) => updates..state = ScreenState.loading)));
    add(GetProductsEvent());
  }
}
