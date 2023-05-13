part of 'app_bloc.dart';




class AppState extends Equatable {
  const AppState(
      {this.isLaunched = false,
      this.isFirstTime = false,
      this.language = AppLanguages.en,
      this.appThemeMode = AppThemeMode.light,
        this.appStatus = Status.startup,
      });
  final Status appStatus;
  final bool isFirstTime;
  final bool isLaunched;
  final AppLanguages language;
  final AppThemeMode appThemeMode;


  get isEnglish => language == AppLanguages.en;

  AppState copyWith({
    bool isLaunched,
    Status appStatus,
    AppLanguages language,
    AppThemeMode appThemeMode,
    bool isFirstTime,

  }) {
    return AppState(
        isLaunched: isLaunched ?? this.isLaunched,
        appThemeMode: appThemeMode ?? this.appThemeMode,
        isFirstTime: isFirstTime ?? this.isFirstTime,
      appStatus: appStatus ?? this.appStatus,
        language: language ?? this.language,

    );
  }



  @override
  List<Object> get props => [
        isLaunched,
        language,
        appThemeMode,
        isFirstTime,
    appStatus,
      ];
}













