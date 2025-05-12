import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olymp_trade/features/dialog/order_success.dart';
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:olymp_trade/features/provider/order_provider.dart';
import 'package:olymp_trade/features/provider/orderrequest_provider.dart';
import 'package:olymp_trade/features/provider/tabbar_provider.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:olymp_trade/features/provider/tradesocket_provider.dart';
import 'package:provider/provider.dart';

class RightSidebarSection extends StatelessWidget {
   const RightSidebarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildSidebarContent(amountController, durationController, context),
      ],
    );
  }

  Widget _buildSidebarContent(TextEditingController amountController,
      TextEditingController durationController, BuildContext context) {
    return Container(
      width: 200,
      color: Colors.black,
      child: Column(
        children: [
          _buildAmountAndDurationFields(
              amountController, durationController, context),
          const SizedBox(height: 10),
          _buildActionButtons(amountController, context),
          const SizedBox(height: 10),
          _buildProfitInfo(context),
        ],
      ),
    );
  }

  Widget _buildAmountAndDurationFields(TextEditingController amountController,
      TextEditingController durationController, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: AmountField(controller: amountController),
        ),
        _buildAmountAdjustmentButtons(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: DurationField(controller: durationController),
        ),
        _buildDurationAdjustmentButtons(),
      ],
    );
  }
 
  Widget _buildAmountAdjustmentButtons() {
    return Row(
      children: [
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: Icon(
              CupertinoIcons.minus,
              color: Colors.grey[800],
              size: 19,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: Icon(
              Icons.add,
              color: Colors.grey[800],
              size: 19,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationAdjustmentButtons() {
    return Row(
      children: [
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: const Icon(
              CupertinoIcons.minus,
              color: Color.fromARGB(255, 163, 185, 179),
              size: 19,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 163, 185, 179),
              size: 19,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
      TextEditingController amountController, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 12),
          child: Row(
            children: [
              _buildOrderEnableButton(
                amountController,
                context,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 12),
          child: Row(
            children: [
              _buildUpButton(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 12),
          child: Row(
            children: [
              _buildDownButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderEnableButton(
    TextEditingController amountController,
    BuildContext context,
  ) {
    return Container(
      height: 60,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 24, 23, 23),
      ),
      child: TextButton(
        onPressed: () {
          String amount = amountController.text;
          if (amount.isNotEmpty) {
            Provider.of<OrderProvider>(context, listen: false);
            // .placeOrder(amount);
          }
          Provider.of<TabVisibilityProvider>(context, listen: false)
              .toggleTabBarVisibility();
        },
        child: const Row(
          children: [
            Text(
              "Enable Orders",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            SizedBox(width: 20),
            Icon(
              Icons.watch_later_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpButton(BuildContext context) {
    return Container(
      height: 54,
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 175, 93),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              createOrder(1, context);
              orderSuccessDialog(context);
              // showInsufficientFundsDialog(context);
            },
            // onPressed: isUpDisabled
            // ? null
            // :(){
            //  handleOrder(0,context);
            // },
            child: const Text(
              'Up',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 50),
          const Icon(
            CupertinoIcons.arrow_up,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildDownButton(BuildContext context) {
    return Container(
      height: 54,
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 73, 86),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              // upDialog(context);
              // showInsufficientFundsDialog(context);
              createOrder(0, context);
              orderSuccessDialog(context);
            },
            // onPressed: isDownDisabled
            //     ?null
            //     :(){
            //       handleOrder(1,context);
            //     },
            child: const Text(
              'Down',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 41),
          const Icon(
            CupertinoIcons.down_arrow,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildProfitInfo(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 22, top: 12),
          child: Text(
            orderProvider.isOrderPlaced
                ? 'Profit: +AED ${orderProvider.amount}'
                : 'Profit AED 0',
            style: const TextStyle(
              color: Color.fromARGB(255, 163, 185, 179),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
  createOrder(int orderType, BuildContext context) async {
    final tradeSettings =
        Provider.of<TradeSettingsProvider>(context, listen: false);
    final orderRequest =
        Provider.of<OrderRequestProvider>(context, listen: false);
    final socketProvider = 
        Provider.of<TradeSocketProvider>(context,listen: false);
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
}

class AmountField extends StatefulWidget {
  final TextEditingController controller;

  const AmountField({super.key, required this.controller});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
        });
      },
      child: Container(
        height: 56,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: isEditing ? Colors.green : Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 24, 23, 23),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? Colors.green : Colors.grey[400]!,
                  fontSize: 12,
                ),
                child: const Text('Amount, AED'),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: widget.controller,
                  enabled: isEditing,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationField extends StatefulWidget {
  final TextEditingController controller;

  const DurationField({super.key, required this.controller});

  @override
  _DurationFieldState createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
  final TextEditingController _controller = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller.text = '00h 02m';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
          _controller.text = '00h 02m';
        });
      },
      child: Container(
        height: 56,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: isEditing ? Colors.green : Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 24, 23, 23),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? Colors.green : Colors.grey[400]!,
                  fontSize: 12,
                ),
                child: const Text('Duration'),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: _controller,
                  enabled: isEditing,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) {
                    String hours = '00';
                    String minutes = '00';

                    if (value.isNotEmpty) {
                      hours = value.substring(
                          0, value.length > 2 ? 2 : value.length);
                      minutes = value.length > 2 ? value.substring(3) : '00';
                    }

                    setState(() {
                      _controller.text = '$hours' + 'h' + '$minutes' + 'm';
                    });

                    _controller.selection = TextSelection.collapsed(
                        offset: _controller.text.length);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}












import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olymp_trade/features/dialog/order_success.dart';
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:olymp_trade/features/provider/order_provider.dart';
import 'package:olymp_trade/features/provider/orderrequest_provider.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:olymp_trade/features/provider/tabbar_provider.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:olymp_trade/features/provider/tradesocket_provider.dart';
import 'package:provider/provider.dart';

class RightSidebarSection extends StatelessWidget {
  const RightSidebarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildSidebarContent(amountController, durationController, context),
      ],
    );
  }

  Widget _buildSidebarContent(TextEditingController amountController,
      TextEditingController durationController, BuildContext context) => Container(
      width: 200,
      color: Colors.black,
      child: Column(
        children: [
          _buildAmountAndDurationFields(
              amountController, durationController, context),
          const SizedBox(height: 10),
          _buildActionButtons(amountController, context),
          const SizedBox(height: 10),
          _buildProfitInfo(context),
        ],
      ),
    );

  Widget _buildAmountAndDurationFields(TextEditingController amountController,
      TextEditingController durationController, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: AmountField(controller: amountController),
        ),
        _buildAmountAdjustmentButtons(context), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: DurationField(controller: durationController),
        ),
        _buildDurationAdjustmentButtons(context),
      ],
    );
  }

  Widget _buildAmountAdjustmentButtons(BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    return Row(
      children: [
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 8),
          child: ElevatedButton(
            onPressed: () {
              tradeSettings.decreaseAmount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ), 
            child: Icon(
              CupertinoIcons.minus,
              color: Colors.grey[800],
              size: 19,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            onPressed: () {
              tradeSettings.increaseAmount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: Icon(
              Icons.add,
              color: Colors.grey[800],
              size: 19,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildDurationAdjustmentButtons(BuildContext context) {
   final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    return Row(
      children: [
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 8),
          child: ElevatedButton(
            onPressed: () {
              tradeSettings.decreaseMinutes();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: const Icon(
              CupertinoIcons.minus,
              color: Color.fromARGB(255, 163, 185, 179),
              size: 19,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            onPressed: () {
              tradeSettings.increaseMinutes();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(75, 30),
            ),
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 163, 185, 179),
              size: 19,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
      TextEditingController amountController, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 12),
          child: Row(
            children: [
              _buildOrderEnableButton(
                amountController,
                context,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 12),
          child: Row(
            children: [
              _buildUpButton(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 12),
          child: Row(
            children: [
              _buildDownButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderEnableButton(
    TextEditingController amountController,
    BuildContext context,
  ) {
    return Container(
      height: 60,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 24, 23, 23),
      ),
      child: TextButton(
        onPressed: () {
          String amount = amountController.text;
          if (amount.isNotEmpty) {
            Provider.of<OrderProvider>(context, listen: false);
            // .placeOrder(amount);
          }
          Provider.of<TabVisibilityProvider>(context, listen: false)
              .toggleTabBarVisibility();
        },
        child: const Row(
          children: [
            Text(
              "Enable Orders",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            SizedBox(width: 20),
            Icon(
              Icons.watch_later_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpButton(BuildContext context) {
    return Container(
      height: 54,
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 175, 93),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              createOrder(1, context);
              orderSuccessDialog(context);
              // showInsufficientFundsDialog(context);
            },
            // onPressed: isUpDisabled
            // ? null
            // :(){
            //  handleOrder(0,context);
            // },
            child: const Text(
              'Up',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 50),
          const Icon(
            CupertinoIcons.arrow_up,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildDownButton(BuildContext context) {
    return Container(
      height: 54,
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 73, 86),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              // upDialog(context);
              // showInsufficientFundsDialog(context);
              createOrder(0, context);
              orderSuccessDialog(context);
            },
            // onPressed: isDownDisabled
            //     ?null
            //     :(){
            //       handleOrder(1,context);
            //     },
            child: const Text(
              'Down',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 41),
          const Icon(
            CupertinoIcons.down_arrow,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildProfitInfo(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 22, top: 12),
          child: Text(
            orderProvider.isOrderPlaced
                ? 'Profit: +AED ${orderProvider.amount}'
                : 'Profit AED 0',
            style: const TextStyle(
              color: Color.fromARGB(255, 163, 185, 179),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
  createOrder(int orderType, BuildContext context) async {
    final tradeSettings =
        Provider.of<TradeSettingsProvider>(context, listen: false);
    final orderRequest =
        Provider.of<OrderRequestProvider>(context, listen: false);
    final socketProvider = 
        Provider.of<TradeSocketProvider>(context,listen: false);
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
}

class AmountField extends StatefulWidget {
  final TextEditingController controller;

  const AmountField({super.key, required this.controller});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
 
  bool isEditing = false;


  @override
  void initState() {
    super.initState();
    widget.controller.text = '0';
  }

  @override
  Widget build(BuildContext context) {

  final selectedAccountNotifier = Provider.of<SelectedAccountNotifier>(context);
  final tradeSettings = Provider.of<TradeSettingsProvider>(context);
  String currency = selectedAccountNotifier.currencySymbol;
 
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
        });
      },
      child: Container(
        height: 56,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isEditing ? const Color.fromARGB(255, 74, 231, 43) : Colors.grey[800]!
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 24, 23, 23),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? Colors.green : Colors.grey[400]!,
                  fontSize: 12,
                ),
                // child: const Text('Amount, AED'),
                child: Text("Amount, $currency "),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: widget.controller,
                  enabled: isEditing,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class DurationField extends StatefulWidget {
  final TextEditingController controller;

  const DurationField({super.key, required this.controller});

  @override
  _DurationFieldState createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
  bool isEditing = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
 
    widget.controller.text = '1 min';
    _focusNode =FocusNode();

    _focusNode.addListener((){
      if(!_focusNode.hasFocus){
        setState(() {
          isEditing = false;

          if(widget.controller.text.trim().isEmpty){
            widget.controller.text = '1 min';
          }
        });
      }
    });
  }

@override
void dispose(){
  _focusNode.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
          widget.controller.text = '00h 02m';
        });
        _focusNode.requestFocus();
      },
      child: Container(
        height: 56,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isEditing ? const Color.fromARGB(255, 74, 231, 43) : Colors.grey[800]!
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 24, 23, 23),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? Colors.green : Colors.grey[400]!,
                  fontSize: 12,
                ),
                child: const Text('Duration'),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: widget.controller,
                  enabled: isEditing,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) {
                    if (value.length < 2) return;

                    String hours = '00';
                    String minutes = '00';

                    if (value.length >= 4) {
                      hours = value.substring(0, 2);
                      minutes = value.substring(2, 4);
                    } else if (value.length == 2) {
                      minutes = value;
                    }
                    widget.controller.text = '$hours' + 'h ' + '$minutes' + 'm';
                    widget.controller.selection = TextSelection.collapsed(
                      offset: widget.controller.text.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



