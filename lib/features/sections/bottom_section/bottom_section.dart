import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:olymp_trade/features/provider/order_provider.dart';
import 'package:olymp_trade/features/provider/orderrequest_provider.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:olymp_trade/features/provider/trade_badge_provider.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:olymp_trade/features/dialog/order_success.dart';
import 'package:olymp_trade/features/provider/tradesocket_provider.dart';
import 'package:olymp_trade/screens/datetime_picker.dart';
import 'package:olymp_trade/screens/price_input.dart';
import 'package:provider/provider.dart';

// class TradeBottomSection extends StatelessWidget {
//   const TradeBottomSection({super.key});

class TradeBottomSection extends StatefulWidget {
  const TradeBottomSection({super.key});

  @override
  State<TradeBottomSection> createState() => _TradeBottomSectionState();
}

class _TradeBottomSectionState extends State<TradeBottomSection> {
  bool isUpDisabled = false;
  bool isDownDisabled = false;

  void handleOrder(int orderType, BuildContext context) async {
    // final balanceProvider = Provider.of<BalanceProvider>(context,listen: false);
    // final tradeSettings = Provider.of<TradeSettingsProvider>(context,listen: false);

    // double? currentBalance = balanceProvider.balance?.availableBalance?.toDouble();
    // double tradeAmount = tradeSettings.amount.toDouble();
    //   print("Current balance: $currentBalance");
    //   print("Trade amount: $tradeAmount");
    // if (currentBalance == null || currentBalance < tradeAmount) {
    //   showInsufficientFundsDialog(context);
    //   return;
    // }

    setState(() {
      if (orderType == 1) {
        isUpDisabled = true;
      } else {
        isDownDisabled = true;
      }
    });

    await createOrder(orderType, context);
    orderSuccessDialog(context);
    Provider.of<TradeBadgeProvider>(context, listen: false).showBadge();

    Future.delayed(const Duration(seconds: 10), () {
      if (!mounted) return;
      setState(() {
        if (orderType == 1) {
          isUpDisabled = false;
        } else {
          isDownDisabled = false;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    final selectedAccountNotifier =
        Provider.of<SelectedAccountNotifier>(context);
    final String currency = selectedAccountNotifier.currencySymbol;
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.background,
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Consumer<TradeSettingsProvider>(
          //     builder: (context, tradeSettings, _) {
          //       return
          //        Text(
          //         tradeSettings.customTimeLabel,
          //         style: TextStyle(
          //           color: AppColors.labelColor,
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       );
          //     },
          //   ),
          //     // Text("Fixed Time Mode",
          //     // style: TextStyle(color: AppColors.labelColor,fontSize: 14,fontWeight: FontWeight.bold),),
          //       const SizedBox(width: 170,),
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //         Consumer<TradeSettingsProvider>(
          //           builder: (context,tradeSettings,_){
          //             return Text(
          //               textAlign:
          //               TextAlign.center ,
          //               orderProvider.isOrderPlaced
          //               ? tradeSettings.customProfitLabel
          //               : 'Profit $currency 0',
          //                 style: TextStyle(
          //                   color: AppColors.labelColor,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //             );
          //           },),

          //       //  Text(
          //       //   orderProvider.isOrderPlaced
          //       //     ? 'Profit $currency ${orderProvider.profit?.toStringAsFixed(2) ?? "0.00"}'
          //       //     : 'Profit $currency 0',
          //       //   style: TextStyle(
          //       //     color: AppColors.labelColor,
          //       //     fontSize: 14,
          //       //     fontWeight: FontWeight.bold,
          //       //   ),
          //       // ),

          //        Tooltip(
          //             message: "This shows your expected profit for the current trade.",
          //             preferBelow: false,
          //             decoration: BoxDecoration(
          //               color: AppColors.borderColor,
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             textStyle: const TextStyle(
          //               color: AppColors.textColor,
          //               fontSize: 13,
          //             ),
          //            child: CircleAvatar(
          //             radius: 10,
          //             backgroundColor: AppColors.borderColor,
          //             child: const Icon(Icons.question_mark_outlined,size: 12,color: Colors.black,),
          //            ),
          //           ),
          //     ],
          //    ),
          //   ],
          // ),
        
          Row(
            children: [
              Consumer<TradeSettingsProvider>(
                builder: (context, tradeSettings, _) {
                  final bool hasCustomLabel = tradeSettings.customTimeLabel.isNotEmpty;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: hasCustomLabel
                    
                      ?Text(
                        textAlign: TextAlign.center,
                        tradeSettings.customTimeLabel,
                        style: TextStyle(
                          color: AppColors.labelColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      )

                    :Row(
                      children: [
                        Text('Fixed Time Mode' ,
                        style: TextStyle(color: AppColors.labelColor,fontSize: 14,fontWeight: FontWeight.bold),),
                    
                        Text(
                        'Profit : $currency 0',
                        style: TextStyle(
                          color: AppColors.labelColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ],
                    )
                  );
                },
              ),
              const SizedBox(width: 160,),
              Consumer<TradeSettingsProvider>(
                builder: (context, tradeSettings, _) {
                // if (tradeSettings.customTimeLabel.isNotEmpty) {
                //     return const SizedBox.shrink(); 
                //   }
                  final bool isPriceSaved = tradeSettings.customProfitLabel.isNotEmpty;
                  if(isPriceSaved){
                    return const SizedBox.shrink();
                  }
                  return Text(
                    orderProvider.isOrderPlaced
                        ? tradeSettings.customProfitLabel
                        : 'Profit :$currency 0',
                    style: TextStyle(
                      color: AppColors.labelColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  );  
                },
              ),
              // const SizedBox(width: 170),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //         Text(
              //           orderProvider.isOrderPlaced
              //               ? tradeSettings.customProfitLabel
              //               : 'Profit $currency 0',
              //           style: TextStyle(
              //             color: AppColors.labelColor,
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              
                  // Tooltip(
                  //   message:
                  //       "This shows your expected profit for the current trade.",
                  //   preferBelow: false,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.borderColor,
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   textStyle: const TextStyle(
                  //     color: AppColors.textColor,
                  //     fontSize: 13,
                  //   ),
                  //   child: CircleAvatar(
                  //     radius: 10,
                  //     backgroundColor: AppColors.borderColor,
                  //     child: const Icon(Icons.question_mark_outlined,
                  //         size: 12, color: AppColors.background),
                  //   ),
                  // ),

              //   ],
              // ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _fixedTimeInputField("1 min", context),
              const SizedBox(width: 5),
              _fixedAmountInputField("AED 0", context),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            OrderButton(
              label: "Down",
              // color: AppColors.buttonDown,
              color: isDownDisabled
                  ? AppColors.buttonDisabled
                  : AppColors.buttonDown,
              icon: CupertinoIcons.arrow_down,
              // onTap: () {
              //   createOrder(0, context);
              // },
              onTap: isDownDisabled
                  ? null
                  : () {
                      handleOrder(0, context);
                      // createOrder(0, context);
                    },
            ),
            const SizedBox(width: 5),
            _iconButton(context, Icons.watch_later_outlined),
            const SizedBox(width: 10),
            OrderButton(
              label: "Up",
              // color: AppColors.buttonUp,
              color:
                  isUpDisabled ? AppColors.buttonDisabled : AppColors.buttonUp,
              icon: CupertinoIcons.arrow_up,
              // onTap: () {
              //   createOrder(1, context);
              // },
              onTap: isUpDisabled
                  ? null
                  : () {
                      handleOrder(1, context);
                      // createOrder(1, context);
                    },
            ),
          ])
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.bgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return _buildBottomDrawerContent(context);
          },
        );
      },
      child: Container(
        width: 50,
        padding: const EdgeInsets.all(12),
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.textColor, size: 24),
      ),
    );
  }

  Widget _fixedTimeInputField(String label, BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      height: screenHeight * 0.05,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 24, 23, 23),
        color: AppColors.bgColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              tradeSettings.decreaseMinutes();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 24, 23, 23),
                color: AppColors.bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.remove,
                  color: AppColors.iconColor, size: 24),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 60,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: TextField(
                controller:
                    TextEditingController(text: "${tradeSettings.minutes} min"),
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  int parsedMinutes =
                      int.tryParse(value.replaceAll(' min', '').trim()) ?? 1;
                  tradeSettings.setMinutes(parsedMinutes);
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '1 min',
                  hintStyle: TextStyle(color: AppColors.textColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              tradeSettings.increaseMinutes();
            },
            child: Container(
              // padding: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),

              // height: screenHeight*0.08,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 24, 23, 23),
                color: AppColors.bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.add, color: AppColors.iconColor, size: 24),
            ),
          ),
        ],
      ),
    );
  }


  Widget _fixedAmountInputField(
    String label,
    BuildContext context,
  ) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    final selectedAccountNotifier =
        Provider.of<SelectedAccountNotifier>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    String currency = selectedAccountNotifier.currencySymbol;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      height: screenHeight * 0.05,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 24, 23, 23),
        color: AppColors.bgColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: tradeSettings.decreaseAmount,
            // child: Icon(Icons.remove, color: Colors.grey[700], size: 24),
            child: const Icon(
              Icons.add,
              color: AppColors.iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 80,
            child: TextField(
              // controller: TextEditingController(text: "AED ${tradeSettings.amount}"),
              controller: TextEditingController(
                  text: "$currency ${tradeSettings.amount}"),
              style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                // hintText: '0.0',
                hintText: 'AED 0',
                hintStyle: TextStyle(color: AppColors.textColor),
              ),
              //   onChanged: (value) {
              //   final clean = value.replaceAll(currency, '').trim();
              //   final newAmount = double.tryParse(clean);
              //   if (newAmount != null) {
              //     tradeSettings.setAmount(newAmount);
              //   }
              // },
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: tradeSettings.increaseAmount,
            child: const Icon(Icons.add, color: AppColors.iconColor, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDrawerContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Text(
              'Place an Order on Halal Marketing Axis',
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TabBar(
              labelColor: Color.fromARGB(255, 151, 240, 50),
              unselectedLabelColor: AppColors.buttonDisabled,
              indicatorColor: Color.fromARGB(255, 183, 240, 51),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "By Price"),
                Tab(text: "By Time"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // const ByPrice(),
                  // ByTime()
                  PriceInputScreen(),
                  TimeSelectionScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

createOrder(int orderType, BuildContext context) async {
  final tradeSettings =
      Provider.of<TradeSettingsProvider>(context, listen: false);
  final orderRequest =
      Provider.of<OrderRequestProvider>(context, listen: false);
  final socketProvider =
      Provider.of<TradeSocketProvider>(context, listen: false);

  OrderCreationRequest request = OrderCreationRequest(
    userId: tradeSettings.userId,
    userIdInt: tradeSettings.userIdInt,
    symbol: tradeSettings.symbol,
    // orderType: tradeSettings.ordertype,
    orderType: orderType,
    amount: tradeSettings.amount,
    strikePrice: tradeSettings.strikeprice,
    orderDuration: tradeSettings.minutes,
  );
  await orderRequest.createOrder(request, context);
  socketProvider.fetchActiveOrders();
}

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final Color color;
  final GestureTapCallback? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                label,
                style: const TextStyle(
                    color: AppColors.background,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: AppColors.background),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildProfitInfo(BuildContext context) {
  final selectedAccountNotifier = Provider.of<SelectedAccountNotifier>(context);
  final String currency = selectedAccountNotifier.currencySymbol;

  return Consumer<OrderProvider>(
    builder: (context, orderProvider, child) {
      final profit = orderProvider.profit;
      final hasProfit = orderProvider.isOrderPlaced;

      return Padding(
        padding: const EdgeInsets.only(right: 22, top: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              hasProfit
                  ? 'Profit $currency ${profit?.toStringAsFixed(2) ?? "0.00"}'
                  : 'Profit $currency 0',
              style: const TextStyle(
                color: AppColors.iconColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            if (hasProfit)
              const Icon(
                CupertinoIcons.arrow_up_right,
                color: Colors.green,
                size: 16,
              ),
          ],
        ),
      );
    },
  );
}

