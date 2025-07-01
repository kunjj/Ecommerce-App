import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/api/home/product.dart';
import 'package:ecommerce/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/bloc/cart/cart_contract.dart';
import 'package:ecommerce/inject/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../core/enums.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var navigatorKey = GlobalKey<NavigatorState>();
  final bloc = Injector.get<CartBloc>();

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
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
            leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back))),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider<CartBloc>(
                create: (context) => bloc,
                child: BlocBuilder<CartBloc, CartData>(builder: (_, __) => _MainContent(bloc: bloc)))));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
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
      child: Text(message, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)));
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
                    child:
                        _ProductList(products: bloc.state.products.where((product) => product.isSelected).toList())))),
        const Divider(height: 2),
        _TotalAmount(totalAmount: bloc.state.totalAmount.toStringAsFixed(2))
      ]);
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemBuilder: (_, index) {
        var product = products[index];
        return _ProductItem(product: product);
      },
      separatorBuilder: (_, __) => const Divider(height: 2),
      itemCount: products.length);
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(children: [
          CachedNetworkImage(
              imageUrl: product.image ?? '',
              width: 80,
              height: 80,
              placeholder: (_, __) => const CircularProgressIndicator(strokeWidth: 2),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          const Gap(6),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Text(product.title ?? '', overflow: TextOverflow.visible, style: const TextStyle(fontSize: 15)),
                RichText(
                    text: TextSpan(style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                  const TextSpan(text: 'Price - ', style: TextStyle(fontSize: 14)),
                  TextSpan(
                      text: '\$${product.price}/-', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ])),
                RichText(
                    text: TextSpan(style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                  const TextSpan(text: 'Rating - ', style: TextStyle(fontSize: 14)),
                  TextSpan(
                      text: '${product.rating?.rate}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ]))
              ]))
        ]));
  }
}

class _TotalAmount extends StatelessWidget {
  const _TotalAmount({required this.totalAmount});

  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(
              onPressed: null, child: Text('\$$totalAmount', style: const TextStyle(color: Colors.black, fontSize: 24)))
        ]));
  }
}
