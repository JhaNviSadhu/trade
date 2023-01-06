import 'package:get/get.dart';
import 'package:trade/main.dart';
import 'package:trade/model/model_trade.dart';
import 'package:trade/network/rest_apis.dart';

import '../network/api_provider.dart';

class TradeController extends GetxController {
  var arrOngoingTrade = <Trade>[].obs;
  var arrOngoingFilter = <Trade>[].obs;
  var arrExpiredFilter = <Trade>[].obs;
  var arrExpiredTrade = <Trade>[].obs;
  var isLoading = false.obs;

  getOngoingTradeList() {
    final parameter = {
      'filters': "ongoing",
    };
    isLoading.value = true;
    sl
        .get<APIProvider>()
        .postAPICallWithData(APIPath.tradeList, parameter)
        .then((response) {
      ModelListTrade _modelSignin = modelListTradeFromMap(response.data);
      if (_modelSignin.status == 200) {
        isLoading.value = false;
        print(_modelSignin);
        arrOngoingTrade.value = _modelSignin.data ?? [];
        arrOngoingFilter.addAll(_modelSignin.data ?? []);
      }
    }).catchError((err) {
      print(err);
      isLoading.value = false;
    });
  }

  getExpiredTradeList() {
    final parameter = {
      'filters': "expired",
    };
    isLoading.value = true;
    sl
        .get<APIProvider>()
        .postAPICallWithData(APIPath.tradeList, parameter)
        .then((response) {
      ModelListTrade _modelSignin = modelListTradeFromMap(response.data);
      if (_modelSignin.status == 200) {
        isLoading.value = false;
        print(_modelSignin);
        arrExpiredTrade.value = _modelSignin.data ?? [];
        arrExpiredFilter.addAll(_modelSignin.data ?? []);
      }
    }).catchError((err) {
      isLoading.value = false;
      print(err);
    });
  }
}
