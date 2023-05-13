

import 'package:test_ososs/core/param/base_param.dart';
import 'package:test_ososs/core/param/no_param.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:test_ososs/core/usecases/base_use_case.dart';

import '../services/theme_store.dart';

class GetAppThemeUseCase extends UseCase<Future<AppThemeMode>, NoParams> {

  final ThemeStore themeStore;

  GetAppThemeUseCase(this.themeStore);

  @override
  Future<AppThemeMode> call(NoParams params) async {
    return await themeStore.getAppTheme();
  }

}

class SetAppThemeUseCase extends UseCase<Future<void>, ThemeParams> {
  final ThemeStore themeStore;

  SetAppThemeUseCase(this.themeStore);

  @override
  Future<void> call(ThemeParams params) async{
    await themeStore.setAppTheme(params.appThemeMode);
  }
}

class ThemeParams extends BaseParams {
 final AppThemeMode appThemeMode;

 ThemeParams(this.appThemeMode);
}