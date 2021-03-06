import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oplin/gen/S.dart';
import 'package:oplin/gen/assets.gen.dart';
import '../../bloc/app_cubit.dart';
import '../../gen/fonts.gen.dart';

class App extends StatelessWidget {
  final Widget child;

  const App({Key? key, required this.child}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppConfig>(
      builder: (context, config) {
        String? fontFamily = "Noto_Sans_TC";
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
            fontFamily: fontFamily,
            splashColor: config.primarySwatch.shade300.withAlpha(50),
            highlightColor: config.primarySwatch.shade300,
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Colors.black),
            appBarTheme: AppBarTheme(
              titleTextStyle: Theme.of(context)
                  .primaryTextTheme
                  .headline6
                  ?.copyWith(fontFamily: fontFamily),
            ),
          ),
          home: DefaultTextStyle(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontFamily: fontFamily, color: Colors.black),
              child: child),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
