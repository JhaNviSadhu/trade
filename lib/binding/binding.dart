import 'package:get/get.dart';
import 'package:trade/controller/signin_controller.dart';
import 'package:trade/controller/trade_controller.dart';

class TreadBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninController(), fenix: true);
    Get.lazyPut(() => TradeController(), fenix: true);
  }
}
