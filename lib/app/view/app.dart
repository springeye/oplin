import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oplin/gen/S.dart';
import '../../bloc/app_cubit.dart';

class App extends StatelessWidget {
  final Widget child;

  const App({Key? key, required this.child}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppConfig>(
      builder: (context, config) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          locale: config.locale,
          theme: ThemeData(
              primarySwatch: config.primarySwatch,
              splashColor: config.primarySwatch.shade300.withAlpha(50),
              highlightColor: config.primarySwatch.shade300,
              textSelectionTheme:
                  const TextSelectionThemeData(cursorColor: Colors.black)),
          home: child,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
