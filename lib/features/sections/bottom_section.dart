import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:olymp_trade/features/provider/orderrequest_provider.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:provider/provider.dart';



class TradeBottomSection extends StatelessWidget {
  const TradeBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
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
          Row(
            children: [
              OrderButton(label: "Down", color: const Color.fromARGB(255, 228, 73, 86), icon: CupertinoIcons.arrow_down,onTap: (){
                print("down button clicked");

                createOrder(0, context);

              },),
              const SizedBox(width: 5),
              _iconButton(context, Icons.watch_later_outlined),
              const SizedBox(width: 10),
              OrderButton(label: "Up", color: const Color.fromARGB(255, 34, 175, 93), icon: CupertinoIcons.arrow_up,onTap: () {
                print("up button clicked");
                    createOrder(1, context);
              },),
            ]
          )
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8),
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _fixedTimeInputField(String label, BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    double screenHeight=MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      height: screenHeight*0.05,
      decoration: BoxDecoration(
        // color: Colors.grey[900],
        color: const Color.fromARGB(255, 24, 23, 23),
        border: Border.all(
          color: Colors.grey[800]!
        ),
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
              // padding: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),

              height: screenHeight*0.05,

              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 23, 23),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.remove, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 5),
         
          SizedBox(
            width: 60,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              
              child: TextField(
                controller: TextEditingController(text: "${tradeSettings.minutes} min"),
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                 onChanged: (value) {
                int parsedMinutes = int.tryParse(value.replaceAll(' min', '').trim()) ?? 1;
                tradeSettings.setMinutes(parsedMinutes); // Use the setMinutes method
              },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '1 min',
                  hintStyle: TextStyle(color: Colors.white),
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
                color: const Color.fromARGB(255, 24, 23, 23),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fixedAmountInputField(String label, BuildContext context,) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    double screenHeight=MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      height: screenHeight*0.05,
      decoration: BoxDecoration(
        // color: Colors.grey[900],
        color: const Color.fromARGB(255, 24, 23, 23),
        border: Border.all(
          color:  Colors.grey[800]!
          ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              tradeSettings.decreaseAmount();
            },
            child: Container(
              // padding: const EdgeInsets.all(8),
              // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 23, 23),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.remove, color: Colors.grey[700], size: 24),
            ),
          ),
          const SizedBox(width: 5),
         
          SizedBox(
            width: 60,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              // padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TextEditingController(text: "AED ${tradeSettings.amount}"),
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
               
               onChanged: (value) {
               double parsedAmount = double.tryParse(value.replaceAll('AED', '').trim()) ?? 0;
               tradeSettings.setAmount(parsedAmount); 
              },
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'AED 0',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              tradeSettings.increaseAmount();
            },
            child: Container(
              // padding: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 23, 23),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add, color: Colors.grey[700], size: 24),
            ),
          ),
        ],
      ),
    );
  }




}

createOrder(int orderType, BuildContext context) async {
  final tradeSettings = Provider.of<TradeSettingsProvider>(context, listen: false); 
  final orderRequest = Provider.of<OrderRequestProvider>(context,listen: false);


  OrderCreationRequest request = OrderCreationRequest(
  userId: tradeSettings.userId,
  userIdInt: tradeSettings.userIdInt,
  symbol: tradeSettings.symbol,
  orderType: tradeSettings.ordertype,
  amount: tradeSettings.amount,
  strikePrice: tradeSettings.strikeprice,
  orderDuration: tradeSettings.minutes,
);
  orderRequest.createOrder(request,context);

}





class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon, required this.onTap,

  });

  final String label;
  final Color color;
  final GestureTapCallback onTap;
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
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

