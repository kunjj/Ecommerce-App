import 'package:ecommerce/api/home/product.dart';

import 'package:ecommerce/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/bloc/cart/cart_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/core/base_state.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartBloc, CartScreen> {
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    bloc.add(InitCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Selected Products',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back))),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider<CartBloc>(
                create: (context) => bloc,
                child: BlocBuilder<CartBloc, CartData>(
                    builder: (_, __) => _MainContent(bloc: bloc)))));
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.bloc});

  final CartBloc bloc;

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
          child: Text(
        message,
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ));
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent({required this.bloc});

  final CartBloc bloc;

  @override
  Widget build(BuildContext context) =>
      Expanded(child: _ProductList(products: bloc.state.products));
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemBuilder: (_, index) {
        var product = products[index];
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(product.image!),
              Text(product.title ?? '')
            ]);
      },
      separatorBuilder: (_, __) => const Divider(height: 2),
      itemCount: products.length);
}
