import 'package:ecommerce/api/home/product.dart';
import 'package:ecommerce/bloc/home/home_bloc.dart';
import 'package:ecommerce/bloc/home/home_contract.dart';
import 'package:ecommerce/ui/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/core/base_state.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/core/view_actions.dart';
import 'package:flutter_base_architecture_plugin/extension/navigation_extensions.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:gap/gap.dart';

import '../../core/constant.dart';
import '../../core/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeBloc, HomeScreen> {
  @override
  void initState() {
    super.initState();
    bloc.add(InitHomeEvent());
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);
    switch (event.runtimeType) {
      case const (NavigateScreen):
        buildHandleActionEvent(event as NavigateScreen);
    }
  }

  void buildHandleActionEvent(NavigateScreen screen) async {
    switch (screen.target) {
      case AppRoutes.cartScreen:
        await navigatorKey.currentContext?.push(
            settings: RouteSettings(name: screen.target),
            builder: (context) => const CartScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Products',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                actions: [
                  IconButton(
                      onPressed: () => bloc.add(NavigateToCartScreenEvent()),
                      icon: const Icon(Icons.shopping_cart))
                ]),
            backgroundColor: Colors.white,
            body: SafeArea(
                child: BlocProvider<HomeBloc>(
                    create: (context) => bloc,
                    child: BlocBuilder<HomeBloc, HomeData>(
                        builder: (_, __) => _MainContent(bloc: bloc))))));
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.bloc});

  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.state.state) {
      case ScreenState.loading:
        return const Center(child: CircularProgressIndicator());
      case ScreenState.content:
        return _ScreenContent(bloc: bloc);
      case ScreenState.error:
        return _DisplayMessage(message: bloc.state.errorMessage!);
      case ScreenState.empty:
        return const _DisplayMessage(message: 'No Products Found');
    }
  }
}

class _DisplayMessage extends StatelessWidget {
  const _DisplayMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
      child: Text(message,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)));
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent({required this.bloc});

  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Search Product',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                            BorderSide(color: Color(0xFFBDBDBD), width: 5))),
                onChanged: (text) =>
                    bloc.add(SearchQueryChangeEvent(query: text)))),
        const Gap(10),
        Expanded(
            child: RefreshIndicator(
                child: bloc.state.products
                        .any((product) => product.isSearchQueryMatched)
                    ? Scrollbar(
                        thumbVisibility: true,
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: _ProductList(
                                products: bloc.state.products
                                    .where((product) =>
                                        product.isSearchQueryMatched)
                                    .toList(),
                                onProductAddToCart: (product) => bloc.add(
                                    AddProductToCartEvent(product: product)))))
                    : const _DisplayMessage(message: 'No Product Found'),
                onRefresh: () async => bloc.add(GetProductsEvent())))
      ]);
}

class _ProductList extends StatelessWidget {
  const _ProductList(
      {required this.products, required this.onProductAddToCart});

  final List<Product> products;
  final Function(Product) onProductAddToCart;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) {
          var product = products[index];
          return _ProductItem(
              product: product, onAddTap: () => onProductAddToCart(product));
        },
        separatorBuilder: (_, __) => const Divider(height: 2),
        itemCount: products.length);
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({required this.product, required this.onAddTap});

  final Product product;
  final Function() onAddTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.network(product.image!, width: 80, height: 80),
            const Gap(8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(product.title ?? '',
                      overflow: TextOverflow.visible,
                      style: const TextStyle(fontSize: 15)),
                  RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                        const TextSpan(
                            text: 'Price - ', style: TextStyle(fontSize: 14)),
                        TextSpan(
                            text: '${product.price}/-',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ])),
                  RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                        const TextSpan(
                            text: 'Rating - ', style: TextStyle(fontSize: 14)),
                        TextSpan(
                            text: '${product.rating?.rate}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ]))
                ],
              ),
            ),
            const Gap(8),
            IconButton(
                onPressed: () => onAddTap(),
                icon: const Icon(Icons.add_circle_outline))
          ],
        ));
  }
}
