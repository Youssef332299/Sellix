import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/providers/lang_cubit.dart';
import 'package:sellix/screens/auth/cubit.dart';
import 'package:sellix/screens/splash/cubit.dart';


List<BlocProvider> multiBlocProviders = [
  BlocProvider<LangCubit>(
    create: (_) => LangCubit()..loadLang(), // تحميل لغة النظام عند الإنشاء
  ),
  BlocProvider<SplashCubit>(
    create: (context) => SplashCubit(),
  ),
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(),
  ),
];
