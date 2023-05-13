
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/blocs/application_bloc/app_bloc.dart';
import 'package:test_ososs/core/helper/extensions/material_color_converter.dart';
import 'package:test_ososs/core/localization/app_lang.dart';
import 'package:test_ososs/core/mediators/communication_types/AppStatus.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:test_ososs/presentation/custom_widgets/text_translation.dart';
import 'package:test_ososs/presentation/hom_flow/screens/home_page.dart';
import 'package:test_ososs/presentation/startup_flow/screens/splash_screen.dart';


import '../core/resources/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appBloc = locator<AppBloc>();

  @override
  void initState() {
    super.initState();
    appBloc.add(LaunchAppEvent());
   // appBloc.watchItemsCount();
   // appBloc.watchItems();
  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appBloc,
      child: BlocBuilder<AppBloc, AppState>(

        builder: (context, state) {
         // print('state.appStatus: ${state.appStatus}');
          if (locator.isRegistered<AppThemeColors>()) {
            locator.unregister<AppThemeColors>();
          }
          locator.registerFactory<AppThemeColors>(
              () => ThemeFactory.colorModeFactory(state.appThemeMode));

          return ScreenUtilInit(
              designSize: const Size(1170, 2532),
              minTextAdapt: true,
              splitScreenMode: true,
              child: state.appStatus == Status.startup
                  ? const SplashPage()
                  : HomePage(),



              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Sheen Store',
                  theme: ThemeData(
                    primarySwatch: locator<AppThemeColors>()
                        .primaryColor
                        .toMaterialColor(),
                    fontFamily: state.isEnglish ? "Poppins" : "cocon",
                    brightness: Brightness.light,
                  ),
                  darkTheme: ThemeData(
                    primarySwatch: locator<AppThemeColors>()
                        .primaryColor
                        .toMaterialColor(),
                    brightness: Brightness.dark,
                  ),
                  themeMode: ThemeFactory.currentTheme(state.appThemeMode),
                  locale: LocalizationManager.localeFactory(state.language),
                  localizationsDelegates:
                      LocalizationManager.createLocalizationsDelegates,
                  supportedLocales: LocalizationManager.createSupportedLocals,
                  home: child,
                );
              });
        },
      ),
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({Key key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  bool data = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                //    context.read<AppBloc>().changeLanguage(
                     //   data ? AppLanguages.en : AppLanguages.ar);
                    data = !data;
                  },
                  child: TextTranslation(TranslationsKeys.changeLanguage),
                ),
                TextButton(
                  onPressed: () {
               //     context.read<AppBloc>().changeTheme();
                  },
                  child: TextTranslation(TranslationsKeys.changeTheme),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
