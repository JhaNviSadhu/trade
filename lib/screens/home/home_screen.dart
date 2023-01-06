import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:get/get.dart';
import 'package:trade/controller/trade_controller.dart';
import 'package:trade/model/model_trade.dart';
import 'package:trade/screens/home/trade_view.dart';
import 'package:trade/utils/color.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final _selectedSegment = ValueNotifier('ongoingTrades');
  TradeController _tradeController = Get.find<TradeController>();

  @override
  void initState() {
    _tradeController.getOngoingTradeList();
    _tradeController.getExpiredTradeList();
    super.initState();
  }

// search query
  filterSearchResults(String query) {
    if (query.isNotEmpty) {
      _tradeController.arrOngoingFilter.value = _tradeController
          .arrOngoingFilter
          .where((p0) => p0.stock?.toLowerCase().contains(query) ?? false)
          .toList();

      _tradeController.arrExpiredFilter.value = _tradeController
          .arrExpiredFilter
          .where((p0) => p0.stock?.toLowerCase().contains(query) ?? false)
          .toList();
      setState(() {});
      _tradeController.arrExpiredFilter.refresh();
      _tradeController.arrOngoingFilter.refresh();
    } else {
      _tradeController.arrOngoingFilter.value =
          _tradeController.arrOngoingTrade;
      _tradeController.arrExpiredFilter.value =
          _tradeController.arrExpiredTrade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: _buildAppbar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSegmentController(),
            const SizedBox(height: 13),
            _buildSearchBar(),
            const SizedBox(height: 13),
            _buildBodyofSegmentController(),
          ],
        ),
      ),
    );
  }

  _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: TextFormField(
        autocorrect: false,
        onChanged: (value) {
          filterSearchResults(value);
        },
        style: Poppins.kTextStyle15Normal400,
        controller: searchController,
        cursorColor: primarycolor,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(247, 247, 247, 1),
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: "Search by stock or mentor name",
          hintStyle: Poppins.kTextStyle15Normal400,
          contentPadding: const EdgeInsets.all(15),
          suffixIcon: Image.asset(
            Images.icSearch,
          ),
        ),
      ),
    );
  }

  _buildBodyofSegmentController() {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedSegment,
      builder: (_, key, __) {
        switch (key) {
          case 'ongoingTrades':
            return Obx(() {
              List<Trade> _modelTrade = (searchController.text.isEmpty)
                  ? _tradeController.arrOngoingTrade
                  : _tradeController.arrOngoingFilter;
              return (_modelTrade.isNotEmpty)
                  ? Expanded(
                      child: TradeView(
                        arrtrade: _modelTrade,
                      ),
                    )
                  : Center(
                      child: (_tradeController.isLoading.isTrue)
                          ? CircularProgressIndicator()
                          : Text(
                              "NO TRADES",
                              style: Poppins.kTextStyle18Normal600,
                            ),
                    );
            });
          case 'expiredTrades':
            return Obx(() {
              List<Trade> _modelTrade = (searchController.text.isEmpty)
                  ? _tradeController.arrExpiredTrade
                  : _tradeController.arrExpiredFilter;
              return (_modelTrade.isNotEmpty)
                  ? Expanded(
                      child: TradeView(
                        arrtrade: _modelTrade,
                      ),
                    )
                  : Center(
                      child: (_tradeController.isLoading.isTrue)
                          ? CircularProgressIndicator()
                          : Text(
                              "NO TRADES",
                              style: Poppins.kTextStyle18Normal600,
                            ),
                    );
            });
          default:
            return const SizedBox();
        }
      },
    );
  }

  _buildSegmentController() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: Container(
        decoration: const BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 9,
              spreadRadius: 1,
              offset: Offset(0, 3))
        ]),
        child: AdvancedSegment(
          controller: _selectedSegment,
          borderRadius: BorderRadius.circular(90),
          itemPadding:
              const EdgeInsets.only(top: 9, bottom: 9, right: 24, left: 24),
          segments: const {
            'ongoingTrades': 'Ongoing Trades',
            'expiredTrades': 'Expired Trades',
          },
          activeStyle: Poppins.kTextStyle14Normal600,
          inactiveStyle:
              Poppins.kTextStyle14Normal600.copyWith(color: Colors.black),
          backgroundColor: Colors.white,
          sliderColor: primarycolor,
        ),
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      elevation: 8,
      title: Text(
        "Trade Recommendations",
        style: Poppins.kTextStyle18Normal600,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(Images.icFilter),
        )
      ],
    );
  }
}
