import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/app/my_app.dart';
import 'package:hostelway/firebase_options.dart';
import 'package:talker/talker.dart';

class DebugBlocObserver extends BlocObserver {
  final talker = Talker(
    settings: TalkerSettings(
      enabled: true,
      useHistory: true,
      useConsoleLogs: true,
    ),
    logger: TalkerLogger(),
  );

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    talker.log(event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    talker.error(error);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    Bloc.observer = DebugBlocObserver();
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(MyApp(
    navigatorKey: navigatorKey,
  ));
}

Size get size => MediaQuery.of(navigatorKey.currentContext!).size;

GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
