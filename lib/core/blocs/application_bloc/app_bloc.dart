import 'dart:async';


// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


//import 'package:json_serializable/builder.dart';

import 'package:test_ososs/core/localization/app_lang.dart';
import 'package:test_ososs/core/mediators/bloc_hub/bloc_member.dart';
import 'package:test_ososs/core/mediators/communication_types/AppStatus.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:test_ososs/presentation/fa%C3%A7ades/app_facade.dart';

import '../../usecases/app_theme_usecases.dart';


part 'app_event.dart';

part 'app_state.dart';



class AppBloc  extends Bloc<AppEvent, AppState> with BlocMember {
  final AppUiFacade appUiFacade;

  AppBloc({
    this.appUiFacade,
  }) : super(const AppState()) {
    /// App Events
    on<LaunchAppEvent>(_onLaunchApp);
    on<AppLanguageEvent>(_onAppLanguage);
    on<AppThemeModeEvent>(_onAppThemeMode);

  }

  // @override
  // void receive(String from, CommunicationType data) {
  //   print("message Received $data");
  //
  //   switch (data.runtimeType.toString()) {
  //
  //     case 'AppStatus':
  //     //     setAppStatus(data);fconver
  //     case 'StringComType':
  //       {
  //         print("StringComType${data} ");
  //           if(data is StringComType &&data.data!="Success")
  //           add(AddUuid(uuid: data));
  //
  //         else
  //           {
  //             add(DeletStateEvent());
  //           }
  //         break;
  //       }
  //     case 'ObjectResultModel':
  //       {
  //         add(AddCaverageCodeToCaverageState(objectResultModel: data));
  //         break;
  //       }
  //
  //   }
  // }


}

extension AppBlocMappers on AppBloc {
  void _onLaunchApp(LaunchAppEvent event, Emitter<AppState> emit) async {
    final appTheme = await appUiFacade.getAppTheme();
   // final isFirstTime = await appUiFacade.isItFirstInit();
    AppLanguages language = await appUiFacade.getSessionLang();

    // if(language.)
    //   {
    //     print("enter too");
    //     await appUiFacade.sessionManager.persistLang("en");
    //     language=AppLanguages.en;
    //   }

    // await appUiFacade.sessionManager.persistLang("en");
    // if (isFirstTime) {
    //   appUiFacade.setFirstTime();
    // }
    //final appStatus = await appUiFacade.checkLoginStatus();

    await Future.delayed(const Duration(seconds: 10));
    print("langage${language}");
    emit(
      state.copyWith(
          isLaunched: true,
          appThemeMode: appTheme,
         // isFirstTime: isFirstTime,
          language: language,
          appStatus: Status.authorized
      ),
    );
  }



  void _onAppLanguage(AppLanguageEvent event, Emitter<AppState> emit) async {
    await appUiFacade.sessionManager.persistLang(event.languages.name);
    emit(state.copyWith(language: event.languages));
  }

  void _onAppThemeMode(AppThemeModeEvent event, Emitter<AppState> emit) async {
    AppThemeMode appThemeMode = _getContraryTheme(state.appThemeMode);
    emit(state.copyWith(appThemeMode: event.appThemeMode ?? appThemeMode));
    await appUiFacade.setAppTheme(event.appThemeMode ?? appThemeMode);
  }

  AppThemeMode _getContraryTheme(AppThemeMode currentMode) {
    return currentMode == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
  }

}



