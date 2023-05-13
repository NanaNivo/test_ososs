import 'package:dio/dio.dart';

//import 'package:ecommerce_template/domain/repositories/auth_repository.dart';





import 'package:get_it/get_it.dart';
import 'package:test_ososs/core/api/auth_interceptor.dart';
import 'package:test_ososs/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:test_ososs/core/mediators/bloc_hub/hub.dart';
import 'package:test_ososs/core/mediators/bloc_hub/members_key.dart';
import 'package:test_ososs/core/services/session_manager.dart';
import 'package:test_ososs/core/services/theme_store.dart';
import 'package:test_ososs/core/usecases/app_theme_usecases.dart';
import 'package:test_ososs/presentation/fa%C3%A7ades/app_facade.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:test_ososs/presentation/hom_flow/dataSource/data_source_home_imp.dart';
import 'package:test_ososs/presentation/hom_flow/repository/repository_home.dart';
import 'package:test_ososs/presentation/hom_flow/repository/repository_home_Imp.dart';
import 'package:test_ososs/presentation/hom_flow/usecase/usecase_pokemon_list.dart';

import '../core/blocs/application_bloc/app_bloc.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());

  locator.registerLazySingleton<ThemeStore>(() => ThemeStore());



  locator.registerLazySingleton<SetAppThemeUseCase>(
      () => SetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<GetAppThemeUseCase>(
      () => GetAppThemeUseCase(locator<ThemeStore>()));



 locator.registerLazySingleton<SessionManager>(() => SessionManager());

  locator.registerLazySingleton<AppUiFacade>(() => AppUiFacade(
    //    checkFirstInitUseCase: locator<CheckFirstInitUseCase>(),
      getAppThemeUseCase: locator<GetAppThemeUseCase>(),
    setAppThemeUseCase: locator<SetAppThemeUseCase>(),
   // setFirstTimeUseCase: locator<SetFirstTimeUseCase>(),
    sessionManager: locator<SessionManager>(),
      ));


  locator.registerLazySingleton<AppBloc>(
      () => AppBloc(appUiFacade: locator<AppUiFacade>()));
  locator.registerFactory<Dio>(() => Dio());

  locator.registerLazySingleton<AuthInterceptor>(
          () => AuthInterceptor(locator<SessionManager>(), locator<Dio>()));
  locator.registerLazySingleton<HomeBloc>(
          () => HomeBloc());
  locator.registerLazySingleton(() => DataSourceHomeImp());
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp(locator<DataSourceHomeImp>()));
  locator.registerLazySingleton<PokemonListUseCase>(() => PokemonListUseCase(homeRepository: locator<HomeRepository>()));

 // locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  // locator.registerLazySingleton<GetImageFromCameraUseCase>(
  //     () => GetImageFromCameraUseCase(locator<ImagePickerService>()));

  // locator.registerLazySingleton<GetImageFromGalleryUseCase>(
  //     () => GetImageFromGalleryUseCase(locator<ImagePickerService>()));

  locator<BlocHub>().registerByName(locator<AppBloc>(), MembersKeys.appBloc);


}
