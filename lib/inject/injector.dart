// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:ecommerce/api/api_response.dart';
import 'package:ecommerce/api/home/home_api.dart';
import 'package:ecommerce/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/bloc/home/home_bloc.dart';
import 'package:ecommerce/services/home_service.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

abstract class Injector {
  static void setUp() {
    // Configure Dio
    _configureDio();

    // Register Apis
    _registerApis();

    // Register Services
    _registerServices();

    // Register Bloc
    _registerBloc();
  }

  static void _configureDio() => _getIt.registerLazySingleton<Dio>(() => Dio());

  static void _registerApis() {
    _getIt.registerLazySingleton<ApiClient>(() => ApiClient(_getIt.get<Dio>()));
    _getIt.registerLazySingleton<HomeApi>(() => HomeApi(_getIt.get<ApiClient>()));
  }

  static void _registerServices() {
    _getIt.registerLazySingleton(() => HomeService(_getIt.get<HomeApi>()));
  }

  static void _registerBloc() {
    _getIt.registerFactory(() => CartBloc(_getIt.get<HomeService>()));
    _getIt.registerFactory(() => HomeBloc(_getIt.get<HomeService>()));
  }

  static T get<T extends Object>() => _getIt.get<T>();
}
