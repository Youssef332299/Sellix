import 'package:bloc/bloc.dart';
import 'package:sellix/screens/web/set_data/view.dart';
import 'package:sellix/screens/web/web_admin_login/view.dart';

import '../../../core/navigation/navigation.dart';
import 'state.dart';

class Web_admin_loginCubit extends Cubit<Web_admin_loginState> {
  Web_admin_loginCubit() : super(Web_admin_loginState().init());


  bool endAnimationText = false;


  Future<void> onAnimationTextEnd(context) async {
    endAnimationText = true;
    navigateAndRemoveUntilWithScale(context, SetDataPage());
  }

}
