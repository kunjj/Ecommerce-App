import 'package:ecommerce/api/home/product.dart';
import 'package:ecommerce/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/bloc/cart/cart_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/core/base_state.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:gap/gap.dart';

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
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
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
        return const _DisplayMessage(message: 'No Products Selected');
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

  final CartBloc bloc;

  @override
  Widget build(BuildContext context) => Column(children: [
    const Gap(10),
        Expanded(
            child: Scrollbar(
                thumbVisibility: true,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _ProductList(
                        products: bloc.state.products
                            .where((product) => product.isSearchQueryMatched)
                            .toList(),
                        onRemoveTap: (product) =>
                            bloc.add(RemoveProductEvent(product: product))))))
      ]);
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.products, required this.onRemoveTap});

  final List<Product> products;
  final Function(Product) onRemoveTap;

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemBuilder: (_, index) {
        var product = products[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(product.image!, width: 80, height: 80),
                const Gap(8),
                Expanded(
                    child: Text(product.title ?? '',
                        overflow: TextOverflow.visible)),
                const Gap(8),
                IconButton(
                    onPressed: () => onRemoveTap(product),
                    icon: const Icon(Icons.remove_circle_outline_outlined))
              ]),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 2),
      itemCount: products.length);
}
