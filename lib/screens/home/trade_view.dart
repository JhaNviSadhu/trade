import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:trade/model/model_trade.dart';
import 'package:trade/utils/color.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/images.dart';

class TradeView extends StatefulWidget {
  final List<Trade> arrtrade;
  const TradeView({super.key, required this.arrtrade});

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.arrtrade.length,
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 30),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 5,
              )
            ],
          ),
          child: _buildTradeCardView(trade: widget.arrtrade[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 20);
      },
    );
  }

  _buildTradeCardView({Trade? trade}) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: primarycolor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.58,
                  child: Text(
                    "${trade?.stock}",
                    style: Poppins.kTextStyle15Normal600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  "${DateFormat('dd-MM-yyyy').format(trade?.postedDate ?? DateTime.now())}",
                  style: Inter.kTextStyle12Normal400,
                ),
                const SizedBox(width: 13),
                Image.asset(Images.icArrowcircle),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoWidget(
                    title: "Type:",
                    value: Text(
                      "${trade?.type}",
                      style: Inter.kTextStyle14Normal500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoWidget(
                    title: "Stock Loss:",
                    value: Row(
                      children: [
                        Image.asset(Images.icRupee),
                        Text(
                          "${trade?.stopLossPrice}",
                          style: Inter.kTextStyle14Normal500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoWidget(
                    title: "Entry:",
                    value: Row(
                      children: [
                        Image.asset(Images.icRupee),
                        Text(
                          "${trade?.entryPrice}",
                          style: Inter.kTextStyle14Normal500,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoWidget(
                    title: "Stock Name:",
                    value: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        "${trade?.name}",
                        style: Inter.kTextStyle14Normal500,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoWidget(
                    title: "Exit:",
                    value: Row(
                      children: [
                        Image.asset(Images.icRupee),
                        Text(
                          "${trade?.exitPrice} ",
                          style: Inter.kTextStyle14Normal500,
                        ),
                        Image.asset(Images.icDash),
                        Image.asset(Images.icRupee),
                        Text(
                          "${trade?.exitHigh}",
                          style: Inter.kTextStyle14Normal500,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoWidget(
                    title: "Action:",
                    value: Text(
                      "${trade?.action}",
                      style: Inter.kTextStyle14Normal500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 5),
              _buildInfoWidget(
                title: "Status:",
                value: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 189, 177, 0.1),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12, top: 2.5, bottom: 2.5),
                    child: Text(
                      "${trade?.status}",
                      style: Inter.kTextStyle12Normal400
                          .copyWith(color: primarycolor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 80),
              _buildInfoWidget(
                title: "Posted by:",
                value: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 189, 177, 0.1),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12, top: 5, bottom: 5),
                    child: GradientText(
                      '${trade?.user?.name} ',
                      style: Inter.kTextStyle14Normal500,
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      radius: 6,
                      colors: const [
                        Color.fromRGBO(0, 200, 188, 1),
                        Color.fromRGBO(3, 152, 143, 1)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildInfoWidget({title, value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: Inter.kTextStyle13Normal500,
        ),
        const SizedBox(height: 5),
        value,
      ],
    );
  }
}
