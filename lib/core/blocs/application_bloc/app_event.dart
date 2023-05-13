part of 'app_bloc.dart';

abstract class AppEvent {}

class LaunchAppEvent extends AppEvent {}

class AppLanguageEvent extends AppEvent {
  final AppLanguages languages;

  AppLanguageEvent(this.languages);
}

class AppThemeModeEvent extends AppEvent {
  final AppThemeMode appThemeMode;

  AppThemeModeEvent({this.appThemeMode});
}

