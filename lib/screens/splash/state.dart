import '../../core/enum/screen_enum.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigate extends SplashState {
  final AppPlatform platform;
  final bool firstTime;

  SplashNavigate({
    required this.platform,
    required this.firstTime,
  });
}

class SplashError extends SplashState {
  final String message;
  SplashError(this.message);
}
