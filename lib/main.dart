import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/core/constants/constants.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/providers/app_providers.dart';
import 'package:sellix/core/providers/lang_cubit.dart';
import 'package:sellix/core/widgets/circle_progras_indicator.dart';
import 'package:sellix/screens/auth/view.dart';
import 'package:sellix/screens/splash/view.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/inventory/components/inventory_table.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/inventory/view.dart';
import 'package:sellix/screens/web/set_data/view.dart';
import 'package:sellix/screens/web/web_admin_login/view.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HardwareKeyboard.instance.addHandler((event) => false);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SellixApp());
}

class SellixApp extends StatelessWidget {
  const SellixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: multiBlocProviders,
      child: BlocBuilder<LangCubit, Locale>(
        builder: (context, locale) {
          return FutureBuilder(
            future: TranslationService.load(locale),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return loading();
              }
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark(),
                darkTheme: ThemeData(
                  fontFamily: cairoFonts,
                  scaffoldBackgroundColor: AppColors.backgroundDark,
                  primaryColor: AppColors.primary500,
                ),
                locale: locale,
                supportedLocales: const [Locale('ar'), Locale('en')],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: Web_admin_loginPage(),
                // home: SplashView(),
                builder: (context, child) => child!,
              );
            },
          );
        },
      ),
    );
  }
}

// 170329
// 376118
