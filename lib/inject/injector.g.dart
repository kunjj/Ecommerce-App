// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _registerMiscModules() {}
  @override
  void _registerCache() {}
  @override
  void _registerApis() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => HomeApi(c.resolve<ApiClient>()))
      ..registerSingleton((c) => ApiClient());
  }

  @override
  void _registerServices() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => HomeService(c.resolve<HomeApi>()));
  }

  @override
  void _registerBlocProviders() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => HomeBloc(c.resolve<HomeService>()))
      ..registerFactory((c) => CartBloc(c.resolve<HomeService>()));
  }
}
