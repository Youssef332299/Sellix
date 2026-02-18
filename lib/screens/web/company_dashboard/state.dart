import '../../../core/enum/screen_enum.dart';

class CompanyDashboardState {
  final DashboardPageType currentPage;


  const CompanyDashboardState({required this.currentPage});


  factory CompanyDashboardState.initial() {
    return const CompanyDashboardState(currentPage: DashboardPageType.dashboard);
  }


  CompanyDashboardState copyWith({DashboardPageType? currentPage}) {
    return CompanyDashboardState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}