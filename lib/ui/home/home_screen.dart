import 'package:ecommerce/api/home/product.dart';
import 'package:ecommerce/bloc/home/home_bloc.dart';
import 'package:ecommerce/bloc/home/home_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/core/base_state.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/core/view_actions.dart';
import 'package:flutter_base_architecture_plugin/extension/navigation_extensions.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeBloc, HomeScreen> {
  var navigatorKey = GlobalKey<NavigatorState>();

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
        break;
    }
  }

  void buildHandleActionEvent(NavigateScreen screen) async {
    switch (screen.target) {
      case 'Cart Screen':
        navigatorKey.currentContext?.pushAndRemoveUntil(
            settings: RouteSettings(name: screen.target),
            builder: (context) => const SizedBox());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products',
              style: TextStyle(color: Colors.black, fontSize: 16)),
          actions: [
            IconButton(
                onPressed: () => bloc.add(NavigateToCartScreenEvent()),
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider<HomeBloc>(
                create: (context) => bloc,
                child: BlocBuilder<HomeBloc, HomeData>(
                    builder: (_, __) => _MainContent(bloc: bloc)))));
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
          child: Text(
        message,
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ));
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent({required this.bloc});

  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) => Column(children: [
        TextField(
            decoration: const InputDecoration(hintText: 'Search Product'),
            onChanged: (text) => bloc.add(SearchQueryChangeEvent(query: text))),
        const Gap(10),
        Expanded(
            child: _ProductList(
                products: bloc.state.products,
                onProductAddToCart: (product) =>
                    bloc.add(AddProductToCartEvent(product: product))))
      ]);
}

class _ProductList extends StatelessWidget {
  const _ProductList(
      {required this.products, required this.onProductAddToCart});

  final List<Product> products;
  final Function(Product) onProductAddToCart;

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemBuilder: (_, index) {
        var product = products[index];
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(product.image!),
              Text(product.title ?? ''),
              IconButton(
                  onPressed: () => onProductAddToCart(product),
                  icon: const Icon(Icons.add))
            ]);
      },
      separatorBuilder: (_, __) => const Divider(height: 2),
      itemCount: products.length);
}
