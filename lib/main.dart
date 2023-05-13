import 'package:flutter/material.dart';
import 'package:test_ososs/app+injection/di.dart';


import 'package:flutter/material.dart';
import 'package:test_ososs/core/error/http/forbidden_error.dart';


import 'app+injection/app.dart';
import 'app+injection/di.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if(error is ForbiddenError) {
     // locator<AuthBloc>().add(LogoutEvent());
    }
    super.onError(bloc, error, stackTrace);
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage = await HydratedStorage.build(
  //     storageDirectory: await getTemporaryDirectory());

  await setUpLocator();

  runApp(const App());
}
