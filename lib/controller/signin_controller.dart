import 'package:get/get.dart';
import 'package:trade/main.dart';
import 'package:trade/model/model_signin.dart';
import 'package:trade/network/api_provider.dart';
import 'package:trade/network/rest_apis.dart';
import 'package:trade/screens/home/home_screen.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/prefs.dart';

class SigninController extends GetxController {
  login({mobileNumber, countryCode}) {
    final parameter = {
      'country_code': countryCode,
      'mobile': mobileNumber,
      'otp': '1234',
      'device_id': Prefs.getString(kdeviceId),
      'device_type': Prefs.getString(kdeviceType),
    };

    sl
        .get<APIProvider>()
        .postAPICallWithData(APIPath.verifyOtp, parameter)
        .then((response) {
      ModelSignin _modelSignin = modelSiginFromMap(response.data);
      if (_modelSignin.status == 200) {
        print(_modelSignin);
        Prefs.setBool(kisLogin, true);
        Prefs.setString(ktoken, _modelSignin.data?.token ?? '');
        Get.off(() => const HomeScreen());
      }
    }).catchError((err) {
      print(err);
    });
  }
}
