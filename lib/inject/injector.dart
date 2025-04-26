// ignore_for_file: constant_identifier_names

import 'package:ecommerce/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/bloc/home/home_bloc.dart';
import 'package:flutter_base_architecture_plugin/core/network/rest_api_client.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/injector_imports.dart';

import '../api/home/home_api.dart';
import '../services/home_service.dart';

part 'injector.g.dart';

abstract class Injector extends BaseInjector {
  static late KiwiContainer container;

  static Future<bool> setup() async {
    container = BaseInjector.baseContainer;

    _$Injector()._configure();
    return true;
  }

  void _configure() {
    // Configure modules here
    _registerMiscModules();
    _registerApis();
    _registerServices();
    _registerCache();
    _registerBlocProviders();
  }

  void _registerMiscModules();

  /// Register Data Stores
  void _registerCache();

  /// Register Apis
  @Register.singleton(HomeApi)
  void _registerApis();

  /// Register Services
  @Register.singleton(HomeService)
  void _registerServices();

  /// Register Bloc dependencies
  @Register.factory(HomeBloc)
  @Register.factory(CartBloc)
  void _registerBlocProviders();
}
