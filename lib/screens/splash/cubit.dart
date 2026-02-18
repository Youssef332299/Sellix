import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/constants/constants.dart';
import '../../core/app/app_platfroms.dart';
import 'state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    init();
  }
  void init() {
    Future.delayed(const Duration(seconds: 2), () {
      resolveStartRoute();
    });
  }

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }

  Future<void> resolveStartRoute() async {
    emit(SplashLoading());

    try {
      final platform = getCurrentPlatform();
      final dataSaved = await isFirstTime();
      dataSaved == false ? firstTime = false : null;
      emit(
        SplashNavigate(
          platform: platform,
          firstTime: firstTime,
        ),
      );
    } catch (e) {
      emit(SplashError('Error loading app'));
    }
  }

}
